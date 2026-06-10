-- ============================================================================
-- NAME
--   wingmate-multicloud-graph.sql
--
-- DESCRIPTION
--   Creates deterministic synthetic relationship tables and the
--   MULTICLOUD_GRAPH SQL property graph used by the Multicloud Wingmate graph
--   visualization. Run this after loading OCI_EXA_INFR, OCI_EXA_VM_CLUSTER,
--   OCI_CDB, and OCI_PDB.
--
-- NOTES
--   ORA_SQLGRAPH_TO_JSON is a rendering helper for the APEX Graph Visualization
--   plug-in. It does not create graph data. This script creates the graph
--   object that GRAPH_TABLE(MULTICLOUD_GRAPH ...) queries.
-- ============================================================================

BEGIN
    EXECUTE IMMEDIATE 'DROP PROPERTY GRAPH multicloud_graph';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE oci_cdb_pdb_edge PURGE';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE oci_vm_cluster_cdb_edge PURGE';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE oci_exa_vm_cluster_edge PURGE';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE oci_exa_vm_cluster_edge (
    edge_id           NUMBER PRIMARY KEY,
    exa_infra_id      NUMBER NOT NULL,
    vm_cluster_id     NUMBER NOT NULL,
    relationship_type VARCHAR2(64) DEFAULT 'HOSTS_VM_CLUSTER'
);

CREATE TABLE oci_vm_cluster_cdb_edge (
    edge_id           NUMBER PRIMARY KEY,
    vm_cluster_id     NUMBER NOT NULL,
    cdb_id            NUMBER NOT NULL,
    relationship_type VARCHAR2(64) DEFAULT 'HOSTS_CDB'
);

CREATE TABLE oci_cdb_pdb_edge (
    edge_id           NUMBER PRIMARY KEY,
    cdb_id            NUMBER NOT NULL,
    pdb_id            NUMBER NOT NULL,
    relationship_type VARCHAR2(64) DEFAULT 'CONTAINS_PDB'
);

INSERT INTO oci_exa_vm_cluster_edge (edge_id, exa_infra_id, vm_cluster_id)
VALUES (1, 1, 1);

INSERT INTO oci_exa_vm_cluster_edge (edge_id, exa_infra_id, vm_cluster_id)
VALUES (2, 1, 2);

INSERT INTO oci_exa_vm_cluster_edge (edge_id, exa_infra_id, vm_cluster_id)
VALUES (3, 2, 3);

INSERT INTO oci_vm_cluster_cdb_edge (edge_id, vm_cluster_id, cdb_id)
VALUES (1, 1, 1);

INSERT INTO oci_vm_cluster_cdb_edge (edge_id, vm_cluster_id, cdb_id)
VALUES (2, 1, 2);

INSERT INTO oci_vm_cluster_cdb_edge (edge_id, vm_cluster_id, cdb_id)
VALUES (3, 2, 3);

INSERT INTO oci_vm_cluster_cdb_edge (edge_id, vm_cluster_id, cdb_id)
VALUES (4, 2, 4);

INSERT INTO oci_cdb_pdb_edge (edge_id, cdb_id, pdb_id)
VALUES (1, 1, 1);

INSERT INTO oci_cdb_pdb_edge (edge_id, cdb_id, pdb_id)
VALUES (2, 1, 2);

INSERT INTO oci_cdb_pdb_edge (edge_id, cdb_id, pdb_id)
VALUES (3, 2, 3);

INSERT INTO oci_cdb_pdb_edge (edge_id, cdb_id, pdb_id)
VALUES (4, 4, 4);

INSERT INTO oci_cdb_pdb_edge (edge_id, cdb_id, pdb_id)
VALUES (5, 4, 5);

INSERT INTO oci_cdb_pdb_edge (edge_id, cdb_id, pdb_id)
VALUES (6, 4, 6);

INSERT INTO oci_cdb_pdb_edge (edge_id, cdb_id, pdb_id)
VALUES (7, 4, 7);

INSERT INTO oci_cdb_pdb_edge (edge_id, cdb_id, pdb_id)
VALUES (8, 4, 8);

INSERT INTO oci_cdb_pdb_edge (edge_id, cdb_id, pdb_id)
VALUES (9, 3, 9);

INSERT INTO oci_cdb_pdb_edge (edge_id, cdb_id, pdb_id)
VALUES (10, 3, 10);

COMMIT;

CREATE PROPERTY GRAPH multicloud_graph
    VERTEX TABLES (
        oci_exa_infr
            KEY (exa_infra_id)
            LABEL exadata_infrastructure
            PROPERTIES (exa_infra_id, name, region, multicloud),
        oci_exa_vm_cluster
            KEY (vm_cluster_id)
            LABEL exadata_vm_cluster
            PROPERTIES (vm_cluster_id, name, region, multicloud),
        oci_cdb
            KEY (cdb_id)
            LABEL container_database
            PROPERTIES (cdb_id, name, region, multicloud),
        oci_pdb
            KEY (pdb_id)
            LABEL pluggable_database
            PROPERTIES (pdb_id, name, region, multicloud)
    )
    EDGE TABLES (
        oci_exa_vm_cluster_edge
            KEY (edge_id)
            SOURCE KEY (exa_infra_id) REFERENCES oci_exa_infr (exa_infra_id)
            DESTINATION KEY (vm_cluster_id) REFERENCES oci_exa_vm_cluster (vm_cluster_id)
            LABEL hosts_vm_cluster
            PROPERTIES (edge_id, relationship_type),
        oci_vm_cluster_cdb_edge
            KEY (edge_id)
            SOURCE KEY (vm_cluster_id) REFERENCES oci_exa_vm_cluster (vm_cluster_id)
            DESTINATION KEY (cdb_id) REFERENCES oci_cdb (cdb_id)
            LABEL hosts_cdb
            PROPERTIES (edge_id, relationship_type),
        oci_cdb_pdb_edge
            KEY (edge_id)
            SOURCE KEY (cdb_id) REFERENCES oci_cdb (cdb_id)
            DESTINATION KEY (pdb_id) REFERENCES oci_pdb (pdb_id)
            LABEL contains_pdb
            PROPERTIES (edge_id, relationship_type)
    );

SELECT graph_name
FROM user_property_graphs
WHERE graph_name = 'MULTICLOUD_GRAPH';

SELECT *
FROM GRAPH_TABLE(MULTICLOUD_GRAPH
    MATCH (a) -[e]-> (b) -[f]-> (c) -[g]-> (d)
    COLUMNS(
        vertex_id(a) AS aid,
        edge_id(e) AS eid,
        vertex_id(b) AS bid,
        edge_id(f) AS fid,
        vertex_id(c) AS cid,
        edge_id(g) AS gid,
        vertex_id(d) AS did
    )
);
