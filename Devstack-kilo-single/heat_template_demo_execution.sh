curl -g  -X POST -H "X-Auth-Token:57127f8b9c654cd6b7f5137fe250ef6b" http://192.168.33.10:8004/v1/aee128258f514dbf95696587ea9fff3f/stacks -d "{ \
{ \
  "files": {}, \
  "disable_rollback": true, \
  "stack_name": "teststack", \
  "template": { \
    "heat_template_version": "2015-04-30", \
    "description": "Simple template to test heat commands" \
  }, \
  "resources": { \
    "my_instance_port": { \
      "type": "OS::Neutron::port", \
      "properties": { \
        "admin_state_up": "true", \
        "neutwork_id": "fbd7fe69-d511-4fd1-907d-b56af6c148f1", \
        "security_groups": "1ed81a91-8b96-4c9e-a3cc-8a70e0cada60" \
      } \
    }, \
    "my_instance": { \
      "type": "OS::Nova::Server", \
      "properties": { \
        "key_name": "my_key", \
        "flavor": "m1.small", \
        "image": "85666820-e0b0-4fa3-9e97-b026867268c9", \
        "neutwokrs": { \
          "get_resource": "my_instance_port" \
        } \
      } \
    } \
  } \
} " \
| python -m json.tool
