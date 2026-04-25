select
    order_item_id,
    order_id,
    order_status,
    payment_status,
    net_revenue,
    recognized_revenue
from {{ ref('fct_order_items') }}
where
    (
        order_status = 'Completed'
        and payment_status = 'Paid'
        and round(recognized_revenue, 2) != round(net_revenue, 2)
    )
    or
    (
        not (order_status = 'Completed' and payment_status = 'Paid')
        and recognized_revenue != 0
    )