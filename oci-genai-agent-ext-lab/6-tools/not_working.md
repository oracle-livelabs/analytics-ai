For next version. Bug in the product.

### 6. Create a custom Tool ###
- Click again **Create Tool**
- API endpoint calling
- Name: **hello-tool**
- Description: **Respond to Hello or Hi**
- Import API Inline 

```
openapi: "3.0.0"
info:
	title: "Hello API"
	version: "1.0.0"
	description: "Hello"

servers:
	- url: "https://objectstorage.us-chicago-1.oracle123.com"

paths:
	/n/yourNamespace/b:
		post:
			summary: "Create a Bucket"
			operationId: "createBucket"
			parameters:
				- name: namespaceName
					in: path
					required: true
					description: "The Object Storage namespace used for the request."
					schema:
						type: string
			requestBody:
				required: true
				content:
					application/json:
						schema:
							type: object
							properties:
								bucket_name:
									type: string
									description: "The name of the bucket to create."
								compartment_ocid:
									type: string
									description: "The OCID of the compartment where the bucket will be created."
								storage_tier:
									type: string
									enum:
										- Standard
										- Archive
									description: "The storage tier for the bucket."
							required:
								- bucket_name
								- compartment_ocid
							additionalProperties: false
			responses:
				"200":
					description: "Bucket created successfully."
					content:
						application/json:
							schema:
								type: object
								properties:
									bucket_name:
										type: string
									namespace:
										type: string
									time_created:
										type: string
										format: date-time
				"400":
					description: "Invalid input."
				"500":
					description: "Internal server error."
```
    - Authentication Type: None
    - VCN: agext-vcn
    - Subnet: agext-app-subnet
    - **Create Tool**
