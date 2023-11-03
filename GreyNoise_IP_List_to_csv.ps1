# This script scans a list of IP addresses from an input file against the GreyNoise API and returns whether or not that IP has been seen

$headers=@{}
$headers.Add("accept", "application/json")
$headers.Add("content-type", "application/json")
$headers.Add("key", "[GREYNOISE API KEY]")

# Import IP addresses from CSV file. Chage the IP input file name to scan through each csv. (i.e. input_ip_addresses9, input_ip_addresses8, input_ip_addresses7, etc.)
$ip_list = Import-Csv -Path 'input_ip_addresses9.csv' | Select-Object -ExpandProperty "IP"

# Create the body of the request
$body = @{
    "ips" = $ip_list
}

# Convert the body to JSON format
$json_body = $body | ConvertTo-Json

# Send the request to the API
$response = Invoke-WebRequest -Uri 'https://api.greynoise.io/v2/noise/multi/quick' -Method POST -Headers $headers -ContentType 'application/json' -Body $json_body

# Convert the response to a usable format
$data = $response.Content | ConvertFrom-Json

# Export the response data to a CSV file. Chage the output file name to scan through each csv. (i.e. input_ip_addresses9, input_ip_addresses8, input_ip_addresses7, etc.)
$data | Export-Csv -Path 'IP_list_results9.csv' -NoTypeInformation
