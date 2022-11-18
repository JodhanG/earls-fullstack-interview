from django.http import HttpResponse
from google.cloud import bigquery
import os


gcp_credentials = "./gcp.json"
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = gcp_credentials
client = bigquery.Client('spring-ranger-368919')

def index(request):
    return HttpResponse("Hello, world.")

def hacker_news(request):
    
    query = """
        SELECT title, author, time_ts
        FROM `bigquery-public-data.hacker_news.stories`
        ORDER BY time DESC
        LIMIT 5
    """

    query_job = client.query(query)  
    rows = query_job.result()  
    
    output = '<table style="width: 50%;"><tr><th></th><th>Title</th><th>Author</th><th>Date of Publication</th></tr>'
    
    for i, row in enumerate(rows):
        output += f'<tr><td style="font-weight: bold; width: 5%">{i + 1}</td><td>{row.title}</td><td>{row.author}</td><td>{row.time_ts}</td></tr>'
    
    output += '</table>'
    
    return HttpResponse(output)

def github(request):

    query = """
        SELECT author.name AS name, count(commit) AS commits
        FROM `bigquery-public-data.github_repos.sample_commits`
        WHERE EXTRACT(YEAR FROM committer.date) = 2016
        GROUP BY name 
        ORDER BY commits DESC
    """

    query_job = client.query(query)  
    rows = query_job.result()

    output = '<table style="width: 50%;"><tr><th></th><th>Name</th><th>Number of Commits</th></tr>'
    
    for i, row in enumerate(rows):
        output += f'<tr><td style="font-weight: bold; width: 5%">{i + 1}</td><td>{row.name}</td><td>{row.commits}</td></tr>'
    
    output += '</table>'

    return HttpResponse(output)
