import json
json_string = '{"hostname": "PERF-GW2", "data": {"updates": {}, "found_update_count": 0, "changed": false, "reboot_required": false, "installed_update_count": 0, "filtered_updates": {"2b56bf45-3dd7-4a3a-b27e-6b67f84decce": {"id": "2b56bf45-3dd7-4a3a-b27e-6b67f84decce", "filtered_reason": "category_names", "title": "2023-07 Cumulative Update for Windows Server 2019 (1809) for x64-based Systems (KB5028168)", "categories": ["Security Updates"], "kb": ["5028168"], "installed": false}}, "failed": false}}'
result_str=""
data_dict = json.loads(json_string)
if len(data_dict['data']['filtered_updates']) == 0:
    if "msg" in data_dict['data']:
        result_str=data_dict['data']['msg']
    else:
        result_str="Up to date"
else:
    available_updates = data_dict['data']['filtered_updates']
    for i in available_updates:
        result_str="[" + ', '.join(data_dict['data']['filtered_updates'][i]['categories']) + "] - " + data_dict['data']['filtered_updates'][i]['title']
print("Host: " + data_dict['hostname'] + " "+ result_str)