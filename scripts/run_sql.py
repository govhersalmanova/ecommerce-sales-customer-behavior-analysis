"""Run the portfolio's SQLite queries against the bundled synthetic CSV."""

import csv
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
INTEGER_COLUMNS = {"Quantity", "Discount_Pct", "Delivery_Days"}
REAL_COLUMNS = {
    "Unit_Price_AZN", "Rating", "Gross_Revenue_AZN", "Net_Revenue_AZN",
    "Cost_AZN", "Profit_AZN",
}


def main():
    with (ROOT / "ecommerce_sales_data.csv").open(encoding="utf-8-sig", newline="") as source:
        reader = csv.DictReader(source)
        columns = reader.fieldnames
        if not columns:
            raise ValueError("CSV header is missing")
        rows = []
        for row in reader:
            rows.append([
                int(row[col]) if col in INTEGER_COLUMNS else
                float(row[col]) if col in REAL_COLUMNS else row[col]
                for col in columns
            ])

    def quote(identifier):
        return '"' + identifier.replace('"', '""') + '"'

    schema = ", ".join(
        f"{quote(col)} {'INTEGER' if col in INTEGER_COLUMNS else 'REAL' if col in REAL_COLUMNS else 'TEXT'}"
        for col in columns
    )
    with sqlite3.connect(":memory:") as connection:
        connection.execute(f"CREATE TABLE ecommerce_sales ({schema})")
        placeholders = ", ".join("?" for _ in columns)
        connection.executemany(f"INSERT INTO ecommerce_sales VALUES ({placeholders})", rows)
        sql = (ROOT / "analysis_queries.sql").read_text(encoding="utf-8-sig")
        for number, statement in enumerate(filter(str.strip, sql.split(";")), start=1):
            cursor = connection.execute(statement)
            print(f"\nQuery {number}")
            print(" | ".join(column[0] for column in cursor.description))
            for result in cursor:
                print(" | ".join(str(value) for value in result))


if __name__ == "__main__":
    main()
