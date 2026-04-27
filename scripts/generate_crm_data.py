import random
from datetime import datetime, timedelta
from pathlib import Path

import numpy as np
import pandas as pd


# -------------------------------------------------------------------
# Configuration
# -------------------------------------------------------------------

SEED = 42
random.seed(SEED)
np.random.seed(SEED)

BASE_DIR = Path(__file__).resolve().parents[1]
RAW_DATA_DIR = BASE_DIR / "data" / "raw"
RAW_DATA_DIR.mkdir(parents=True, exist_ok=True)

START_DATE = datetime(2023, 1, 1)
END_DATE = datetime(2025, 12, 31)
MAX_OPPORTUNITY_DURATION_DAYS = 180

REGIONS = [
    {"region_id": 1, "region_name": "North America", "country": "United States"},
    {"region_id": 2, "region_name": "Western Europe", "country": "France"},
    {"region_id": 3, "region_name": "DACH", "country": "Germany"},
    {"region_id": 4, "region_name": "Southern Europe", "country": "Spain"},
    {"region_id": 5, "region_name": "Middle East", "country": "United Arab Emirates"},
    {"region_id": 6, "region_name": "North Africa", "country": "Tunisia"},
    {"region_id": 7, "region_name": "West Africa", "country": "Senegal"},
    {"region_id": 8, "region_name": "Central Africa", "country": "Gabon"},
]


# -------------------------------------------------------------------
# Helper functions
# -------------------------------------------------------------------

def random_date(start_date: datetime, end_date: datetime) -> datetime:
    """Generate a random date between two dates."""
    delta = end_date - start_date
    random_days = random.randint(0, delta.days)
    return start_date + timedelta(days=random_days)


def format_date(date_value: datetime) -> str:
    """Format datetime as YYYY-MM-DD."""
    return date_value.strftime("%Y-%m-%d")


def save_csv(df: pd.DataFrame, filename: str) -> None:
    """Save dataframe as CSV in data/raw."""
    output_path = RAW_DATA_DIR / filename
    df.to_csv(output_path, index=False)
    print(f"Generated {filename}: {len(df)} rows")


def build_country_region_map(regions_df: pd.DataFrame) -> dict[str, list[int]]:
    """Build a country-to-region-id lookup."""
    grouped = regions_df.groupby("country")["region_id"].apply(list)
    return grouped.to_dict()


def ensure(condition: bool, message: str) -> None:
    """Raise ValueError when a validation condition is not met."""
    if not condition:
        raise ValueError(message)


# -------------------------------------------------------------------
# Generate regions
# -------------------------------------------------------------------

def generate_regions() -> pd.DataFrame:
    return pd.DataFrame(REGIONS)


# -------------------------------------------------------------------
# Generate customers
# -------------------------------------------------------------------

def generate_customers(regions_df: pd.DataFrame, number_of_customers: int = 500) -> pd.DataFrame:
    industries = [
        "Technology",
        "Finance",
        "Retail",
        "Healthcare",
        "Manufacturing",
        "Education",
        "Telecommunications",
        "Energy",
        "Transportation",
        "Hospitality",
    ]

    company_sizes = ["Small", "Medium", "Enterprise"]

    company_prefixes = [
        "Global",
        "Prime",
        "NextGen",
        "Blue",
        "Green",
        "Smart",
        "Digital",
        "Future",
        "Nova",
        "Elite",
        "Vision",
        "Core",
    ]

    company_suffixes = [
        "Solutions",
        "Systems",
        "Group",
        "Technologies",
        "Partners",
        "Industries",
        "Consulting",
        "Networks",
        "Labs",
        "Services",
    ]

    country_to_region_ids = build_country_region_map(regions_df)
    countries = list(country_to_region_ids.keys())

    customers = []

    for customer_id in range(1, number_of_customers + 1):
        company_name = f"{random.choice(company_prefixes)} {random.choice(company_suffixes)} {customer_id}"

        created_at = random_date(START_DATE, END_DATE)

        customers.append(
            {
                "customer_id": customer_id,
                "customer_name": company_name,
                "industry": random.choice(industries),
                "company_size": random.choice(company_sizes),
                "country": (country := random.choice(countries)),
                "region_id": random.choice(country_to_region_ids[country]),
                "created_at": format_date(created_at),
            }
        )

    return pd.DataFrame(customers)


# -------------------------------------------------------------------
# Generate products
# -------------------------------------------------------------------

def generate_products() -> pd.DataFrame:
    products = [
        ("CRM Starter", "CRM Software", 49),
        ("CRM Professional", "CRM Software", 149),
        ("CRM Enterprise", "CRM Software", 399),
        ("Sales Automation Basic", "Sales Automation", 99),
        ("Sales Automation Pro", "Sales Automation", 249),
        ("Lead Scoring Engine", "Sales Intelligence", 199),
        ("Customer Segmentation", "Analytics", 299),
        ("Revenue Forecasting", "Analytics", 349),
        ("Marketing Attribution", "Marketing", 279),
        ("Email Campaign Suite", "Marketing", 129),
        ("Data Integration Connector", "Data Integration", 499),
        ("API Access Package", "Data Integration", 599),
        ("Advanced Reporting", "Business Intelligence", 199),
        ("Executive Dashboard", "Business Intelligence", 299),
        ("Customer Success Module", "Customer Success", 179),
        ("Support Ticket Analytics", "Customer Success", 149),
        ("AI Sales Assistant", "AI", 699),
        ("Predictive Churn Model", "AI", 799),
        ("Workflow Automation", "Automation", 249),
        ("Enterprise Security Pack", "Security", 399),
        ("Single Sign-On", "Security", 199),
        ("Data Quality Monitor", "Data Quality", 349),
        ("Data Governance Module", "Data Governance", 449),
        ("Partner Portal", "Collaboration", 229),
        ("Mobile Sales App", "Mobile", 159),
        ("Training Package", "Services", 999),
        ("Implementation Package", "Services", 2499),
        ("Premium Support", "Services", 1499),
        ("Custom Integration", "Services", 3999),
        ("Strategic Consulting", "Services", 4999),
    ]

    product_rows = []

    for product_id, product in enumerate(products, start=1):
        product_name, category, unit_price = product

        product_rows.append(
            {
                "product_id": product_id,
                "product_name": product_name,
                "category": category,
                "unit_price": unit_price,
                "created_at": format_date(random_date(START_DATE, END_DATE)),
            }
        )

    return pd.DataFrame(product_rows)


# -------------------------------------------------------------------
# Generate sales representatives
# -------------------------------------------------------------------

def generate_sales_reps(regions_df: pd.DataFrame, number_of_sales_reps: int = 20) -> pd.DataFrame:
    first_names = [
        "Emma",
        "Lucas",
        "Sofia",
        "Noah",
        "Lina",
        "Adam",
        "Nora",
        "Hugo",
        "Ines",
        "Leo",
        "Maya",
        "Ethan",
        "Sarah",
        "Yanis",
        "Clara",
        "Omar",
        "Alice",
        "Nathan",
        "Leila",
        "Victor",
        "Camille",
        "Mathis",
        "Chloe",
    ]

    last_names = [
        "Martin",
        "Dubois",
        "Bernard",
        "Thomas",
        "Robert",
        "Richard",
        "Petit",
        "Durand",
        "Leroy",
        "Moreau",
        "Simon",
        "Laurent",
        "Lefebvre",
        "Michel",
        "Garcia",
        "David",
        "Bertrand",
        "Roux",
        "Vincent",
        "Fournier",
        "Morel",
        "Girard",
        "Andre",
    ]

    sales_reps = []
    region_ids = regions_df["region_id"].tolist()

    for sales_rep_id in range(1, number_of_sales_reps + 1):
        first_name = random.choice(first_names)
        last_name = random.choice(last_names)
        full_name = f"{first_name} {last_name}"
        email = f"{first_name.lower()}.{last_name.lower()}{sales_rep_id}@company.com"

        sales_reps.append(
            {
                "sales_rep_id": sales_rep_id,
                "sales_rep_name": full_name,
                "email": email,
                "region_id": random.choice(region_ids),
                "hire_date": format_date(random_date(datetime(2020, 1, 1), datetime(2024, 12, 31))),
            }
        )

    return pd.DataFrame(sales_reps)


# -------------------------------------------------------------------
# Generate orders
# -------------------------------------------------------------------

def generate_orders(
    customers_df: pd.DataFrame,
    sales_reps_df: pd.DataFrame,
    number_of_orders: int = 3000,
) -> pd.DataFrame:
    order_statuses = ["Completed", "Completed", "Completed", "Completed", "Cancelled", "Returned"]
    payment_statuses = ["Paid", "Paid", "Paid", "Pending", "Failed"]

    customer_ids = customers_df["customer_id"].tolist()
    sales_rep_ids = sales_reps_df["sales_rep_id"].tolist()

    orders = []

    for order_id in range(1, number_of_orders + 1):
        order_date = random_date(START_DATE, END_DATE)

        orders.append(
            {
                "order_id": order_id,
                "customer_id": random.choice(customer_ids),
                "sales_rep_id": random.choice(sales_rep_ids),
                "order_date": format_date(order_date),
                "order_status": random.choice(order_statuses),
                "payment_status": random.choice(payment_statuses),
            }
        )

    return pd.DataFrame(orders)


# -------------------------------------------------------------------
# Generate order items
# -------------------------------------------------------------------

def generate_order_items(
    orders_df: pd.DataFrame,
    products_df: pd.DataFrame,
    min_items_per_order: int = 1,
    max_items_per_order: int = 5,
) -> pd.DataFrame:
    order_items = []
    order_item_id = 1

    products = products_df.to_dict("records")

    for order in orders_df.itertuples(index=False):
        number_of_items = random.randint(min_items_per_order, max_items_per_order)
        selected_products = random.sample(products, number_of_items)

        for product in selected_products:
            quantity = random.randint(1, 10)

            # Slight price variation to simulate negotiated prices
            price_variation = random.uniform(0.90, 1.10)
            unit_price = round(product["unit_price"] * price_variation, 2)

            discount = random.choice([0, 0, 0, 0.05, 0.10, 0.15, 0.20])

            order_items.append(
                {
                    "order_item_id": order_item_id,
                    "order_id": int(order.order_id),
                    "product_id": int(product["product_id"]),
                    "quantity": quantity,
                    "unit_price": unit_price,
                    "discount": discount,
                }
            )

            order_item_id += 1

    return pd.DataFrame(order_items)


# -------------------------------------------------------------------
# Generate opportunities
# -------------------------------------------------------------------

def generate_opportunities(
    customers_df: pd.DataFrame,
    sales_reps_df: pd.DataFrame,
    number_of_opportunities: int = 1200,
) -> pd.DataFrame:
    stages = [
        "Prospecting",
        "Qualification",
        "Proposal",
        "Negotiation",
        "Closed Won",
        "Closed Lost",
    ]

    stage_probabilities = {
        "Prospecting": 0.10,
        "Qualification": 0.25,
        "Proposal": 0.50,
        "Negotiation": 0.70,
        "Closed Won": 1.00,
        "Closed Lost": 0.00,
    }

    customer_ids = customers_df["customer_id"].tolist()
    sales_rep_ids = sales_reps_df["sales_rep_id"].tolist()

    opportunities = []
    latest_possible_created_date = END_DATE - timedelta(days=7)

    for opportunity_id in range(1, number_of_opportunities + 1):
        created_date = random_date(START_DATE, latest_possible_created_date)
        close_date = created_date + timedelta(days=random.randint(7, MAX_OPPORTUNITY_DURATION_DAYS))

        if close_date > END_DATE:
            close_date = END_DATE

        stage = random.choice(stages)
        expected_revenue = round(random.uniform(1000, 100000), 2)
        probability = stage_probabilities[stage]

        opportunities.append(
            {
                "opportunity_id": opportunity_id,
                "customer_id": random.choice(customer_ids),
                "sales_rep_id": random.choice(sales_rep_ids),
                "created_date": format_date(created_date),
                "close_date": format_date(close_date),
                "stage": stage,
                "expected_revenue": expected_revenue,
                "probability": probability,
            }
        )

    return pd.DataFrame(opportunities)


# -------------------------------------------------------------------
# Validation checks
# -------------------------------------------------------------------

def validate_data(
    customers_df: pd.DataFrame,
    products_df: pd.DataFrame,
    regions_df: pd.DataFrame,
    sales_reps_df: pd.DataFrame,
    orders_df: pd.DataFrame,
    order_items_df: pd.DataFrame,
    opportunities_df: pd.DataFrame,
) -> None:
    """Run simple validation checks before saving files."""

    ensure(customers_df["customer_id"].is_unique, "customer_id must be unique")
    ensure(products_df["product_id"].is_unique, "product_id must be unique")
    ensure(regions_df["region_id"].is_unique, "region_id must be unique")
    ensure(sales_reps_df["sales_rep_id"].is_unique, "sales_rep_id must be unique")
    ensure(orders_df["order_id"].is_unique, "order_id must be unique")
    ensure(order_items_df["order_item_id"].is_unique, "order_item_id must be unique")
    ensure(opportunities_df["opportunity_id"].is_unique, "opportunity_id must be unique")

    ensure(orders_df["customer_id"].isin(customers_df["customer_id"]).all(), "orders.customer_id has invalid values")
    ensure(orders_df["sales_rep_id"].isin(sales_reps_df["sales_rep_id"]).all(), "orders.sales_rep_id has invalid values")

    ensure(order_items_df["order_id"].isin(orders_df["order_id"]).all(), "order_items.order_id has invalid values")
    ensure(order_items_df["product_id"].isin(products_df["product_id"]).all(), "order_items.product_id has invalid values")

    ensure(opportunities_df["customer_id"].isin(customers_df["customer_id"]).all(), "opportunities.customer_id has invalid values")
    ensure(opportunities_df["sales_rep_id"].isin(sales_reps_df["sales_rep_id"]).all(), "opportunities.sales_rep_id has invalid values")

    ensure((order_items_df["quantity"] > 0).all(), "quantity must be greater than 0")
    ensure((order_items_df["unit_price"] > 0).all(), "unit_price must be greater than 0")
    ensure((order_items_df["discount"] >= 0).all(), "discount must be greater than or equal to 0")
    ensure((order_items_df["discount"] <= 1).all(), "discount must be less than or equal to 1")
    ensure((opportunities_df["close_date"] >= opportunities_df["created_date"]).all(), "opportunity close date must be on or after created date")

    customer_country_region = customers_df.merge(
        regions_df[["region_id", "country"]],
        on="region_id",
        how="left",
        suffixes=("_customer", "_region"),
    )
    ensure(
        (customer_country_region["country_customer"] == customer_country_region["country_region"]).all(),
        "customers.country must match the assigned region country",
    )

    print("All validation checks passed.")


# -------------------------------------------------------------------
# Main
# -------------------------------------------------------------------

def main() -> None:
    print("Generating CRM synthetic dataset...")

    regions_df = generate_regions()
    customers_df = generate_customers(regions_df)
    products_df = generate_products()
    sales_reps_df = generate_sales_reps(regions_df)
    orders_df = generate_orders(customers_df, sales_reps_df)
    order_items_df = generate_order_items(orders_df, products_df)
    opportunities_df = generate_opportunities(customers_df, sales_reps_df)

    validate_data(
        customers_df=customers_df,
        products_df=products_df,
        regions_df=regions_df,
        sales_reps_df=sales_reps_df,
        orders_df=orders_df,
        order_items_df=order_items_df,
        opportunities_df=opportunities_df,
    )

    save_csv(regions_df, "regions.csv")
    save_csv(customers_df, "customers.csv")
    save_csv(products_df, "products.csv")
    save_csv(sales_reps_df, "sales_reps.csv")
    save_csv(orders_df, "orders.csv")
    save_csv(order_items_df, "order_items.csv")
    save_csv(opportunities_df, "opportunities.csv")

    print("CRM dataset generation completed successfully.")


if __name__ == "__main__":
    main()
