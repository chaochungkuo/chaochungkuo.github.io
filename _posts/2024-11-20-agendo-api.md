---
title: Agendo API
date: 2024-11-20
categories: [IT, API]
tags: [agendo, api]  # TAG names should always be lowercase
published: true
---

Recently I am trying Agendo API and want to record the testing code here, because the documentation on Agendo's site isn't updated.

```python
import json
import requests
import base64

# Agendo API base path
api_url_base = 'https://apieurope.agendoscience.com/'

# your Agendo login credentials
api_email = 'My_Agendo_Email'
api_pwd = 'My_Agendo_Password'

# Encode email and password in Base64
auth_str = f"{api_email}:{api_pwd}"
auth_bytes = auth_str.encode('utf-8')  # Convert to bytes
auth_b64 = base64.b64encode(auth_bytes).decode('utf-8')  # Encode and convert back to string

# Set headers with proper authorization
headers = {
    'Content-Type': 'application/json',
    'Authorization': f'Basic {auth_b64}',
    'From': 'aXprZg=='
}

# Example of using the API URL
api_url = f'{api_url_base}requests/2018'
# API GET requests
response = requests.get(api_url, headers=headers)
response

# Check if the response was successful
if response.status_code == 200:
    data = response.json()  # Parse the response as JSON
    print("Data received:")
    # print(data)
    print(json.dumps(data, indent=4))
else:
    print(f"Failed to retrieve data: {response.status_code}")


# Start ID (latest known ID)
start_id = 2000
requests_data = []  # Store data of all retrieved requests
completed_requests = []  # Store only completed requests
max_attempts = 5  # Number of consecutive failures to stop the loop
class_options = ["GF - Bioinformatic Analysis",
                 "GF - Diagnostic Sequencing Run",
                 "GF - Sequencing"]
# Loop through IDs to retrieve each request
consecutive_failures = 0  # Track consecutive failures to break the loop

for request_id in range(start_id, start_id + 10000):  # Adjust range based on expected future IDs
    # Construct API URL for each request ID
    api_url = f'{api_url_base}requests/{request_id}'
    response = requests.get(api_url, headers=headers)
    
    if response.status_code == 200:
        consecutive_failures = 0  # Reset failure count on success
        request_data = response.json()
        requests_data.append(request_data)  # Store the full request data
        
        # Filter by status and add to completed requests if status is 'Completed'
        if request_data.get('request', {}).get('class') in class_options and \
            request_data.get('request', {}).get('status') == "Approved":
            completed_requests.append(request_data)
        
        print(f"Retrieved request ID {request_id}")
        
    else:
        # Increment failure count and check if max consecutive failures are reached
        consecutive_failures += 1
        if consecutive_failures >= max_attempts:
            print("No more requests found. Stopping iteration.")
            break

# Output completed requests
print("Completed requests:")
print(json.dumps(completed_requests, indent=4))
```
