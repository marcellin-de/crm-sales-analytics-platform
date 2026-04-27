with
    date_bounds as (
        select
            to_date('{{ var("date_spine_start_date", "2023-01-01") }}') as start_date,
            to_date('{{ var("date_spine_end_date", "2025-12-31") }}') as end_date
    ),
    date_spine as (
        select dateadd(day, row_number() over (order by seq4()) - 1, date_bounds.start_date) as date_day
        from table (generator(rowcount => {{ var("date_spine_rowcount", 5000) }}))
        cross join date_bounds
        qualify date_day <= date_bounds.end_date
    ),
    final as (
        select
            to_number(to_char(date_day, 'YYYYMMDD')) as date_key,
            date_day,
            year(date_day) as year,
            quarter(date_day) as quarter,
            month(date_day) as month,
            monthname(date_day) as month_name,
            day(date_day) as day_of_month,
            weekiso(date_day) as iso_week,
            dayofweekiso(date_day) as iso_day_of_week,
            date_trunc('month', date_day) as month_start_date,
            date_trunc('quarter', date_day) as quarter_start_date,
            date_trunc('year', date_day) as year_start_date,
            case
                when dayofweekiso(date_day) in (6, 7) then true
                else false
            end as is_weekend
        from date_spine
    )

select * from final
