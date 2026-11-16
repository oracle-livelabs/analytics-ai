"""Display the workshop CSV as a financial report."""
import csv
from html import escape
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path


def profit(item, kind):
    return (int(item[f'{kind}_revenue'])
            - int(item[f'{kind}_cogs'])
            - int(item[f'{kind}_freight']))


def report():
    rows = []
    totals = [0, 0, 0]
    with Path(__file__).with_name('monthly-financials.csv').open() as data:
        for item in csv.DictReader(data):
            budget = profit(item, 'budget')
            actual = profit(item, 'actual')
            values = [budget, actual, budget - actual]
            totals = [a + b for a, b in zip(totals, values)]
            cells = ''.join(f'<td>${value:,.0f}</td>' for value in values)
            rows.append(f'<tr><th>{escape(item["product"])}</th>{cells}</tr>')
    cells = ''.join(f'<td>${value:,.0f}</td>' for value in totals)
    rows.append(f'<tr><th>Total</th>{cells}</tr>')
    return ('''<!doctype html><html lang="en"><meta charset="utf-8">
<title>Financial report</title>
<style>
body {font: 18px system-ui; margin: 3rem; color: #263238}
table {border-collapse: collapse; margin: 2rem 0}
th, td {padding: .8rem 1.2rem; border-bottom: 1px solid #ccc; text-align: right}
th:first-child {text-align: left}
</style>
<h1>Financial report</h1><p>Budgeted and actual profit in USD.</p>
<table><thead><tr><th>Product</th><th>Budget profit</th>
<th>Actual profit</th><th>Shortfall</th></tr></thead><tbody>'''
            + ''.join(rows) + '</tbody></table></html>').encode()


class ReportHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path != '/':
            self.send_error(404)
            return
        page = report()
        self.send_response(200)
        self.send_header('Content-Type', 'text/html; charset=utf-8')
        self.send_header('Content-Length', str(len(page)))
        self.end_headers()
        self.wfile.write(page)


if __name__ == '__main__':
    server = ThreadingHTTPServer(
        ('0.0.0.0', 8080), ReportHandler,
    )
    server.serve_forever()
