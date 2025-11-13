# References

## Introduction
The reference section provides sample snippets used in the lab, along with key links.

* The complete sample used during the labs is provided below.

```
import nest_asyncio
nest_asyncio.apply()

import asyncio #For Async run 
from typing import Any,Dict # Python types 

from oci.addons.adk import Agent, AgentClient,tool #ADK Agent / tools and clients

from oci.addons.adk.tool.prebuilt import AgenticRagTool #For RAG tool definition 

from oci.addons.adk.mcp import MCPClientStreamableHttp,MCPClientStdio
from mcp.client.stdio import StdioServerParameters
from mcp.client.session_group import StreamableHttpParameters

agent_endpoint="<OCID of Agent endpoint>"
knowledge_id="<OCID of the RAG KnowledgeBase>"

instructions_agent_core = """
    You are an OCI Agent.
    Use RAG tool to answer vector search and oracle sales and annual reports related answers.
    Use tool check_season for all weather related answers.
    Use mcp_tools for github and repo and room availability related answers.
    """


#Definition of our tool and do not forget the @tool decorator
@tool(description="Get the season for a location")
def check_season(location:str) -> Dict[str, Any]:
    """Get the season for a given location

    Args:
      location(str): The location for which season her is queried
    """
    data = {
        "India":"Monsoon",
        "USA":"Summer",
        "Europe":"Summer",
        "Brazil":"Winter"

    }
    try:
        return {"location": location, "season": data[location]}
    except Exception as error:
         return {"location": "Unknown", "season": "Unknown"}

#MCP with Local Library Params 
bnb_mcp_params = StdioServerParameters(
        command="npx",
        args=["-y" ,"@openbnb/mcp-server-airbnb", "--ignore-robots-txt"],
    )

#RAG tool detentions
core_rag_tool = AgenticRagTool(
        name="oci_hol_rag_tool",
        description="RAG tool to answer oracle linux,vector search and sql related queries",
        knowledge_base_ids=[knowledge_id],
    )

#Agent Configuration

async def agent_handler(prompt:str="",init_run:bool=False,delete_session:bool=True,session_id:str=None):
         async with (
                MCPClientStdio(params=bnb_mcp_params,name="bnb mcp") as bnb_client):
            client = AgentClient(
                  auth_type="api_key",#"resource_principal", #"api_key" for local setup,
                  profile="DEFAULT", #OCI config profile name
                  region="eu-frankfurt-1",  # OCI region such as "us-chicago-1" etc or airport code such as "ORD"
                  #config="/home/datascience/master/ssh_keys/oci_config" #
               )
    
            agent_core = Agent(
                client=client,
                agent_endpoint_id=agent_endpoint,
                instructions=instructions_agent_core,
                tools=[check_season,core_rag_tool,await bnb_client.as_toolkit()])
            if init_run:
                agent_core.setup()
            if session_id is not None:
                response = await agent_core.run_async(prompt,delete_session=delete_session,max_steps=5,session_id=session_id)
            else:
                response = await agent_core.run_async(prompt,delete_session=delete_session,max_steps=5)
            return response

question="give availability of room at The Palazzo at The Venetian Resort on 1st Aug 2025"
response = asyncio.run(agent_handler(prompt=question,init_run=True)) 
response.pretty_print()


```

* Link to official documentation.

    - All about OCI Generative AI Agents - https://docs.oracle.com/en-us/iaas/Content/generative-ai-agents/home.htm 

    - Agent Development Kit (ADK) - https://docs.oracle.com/en-us/iaas/Content/generative-ai-agents/adk/api-reference/introduction.htm 

    - Blog about OCI Generative AI Agent - https://blogs.oracle.com/cloud-infrastructure/post/first-principles-oci-ai-agent-platform 



## Acknowledgements

* **Author**
    * **Rahul MR**, Principal Solutions Architect - OCI 
* **Contributors**
    * **Sanjeeva Kalva**, Principal Data Scientist - OCI 