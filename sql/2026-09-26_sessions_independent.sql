-- Saved sessions no longer depend on the protocol tree — BodyTalk Protocol Navigator
-- Owner's request (2026-09-26): sessions must be independent, no integrity
-- constraint between a saved step and dim_protocol_node. Nodes can now be
-- renamed, split or removed without touching saved sessions.
--  1. Each step keeps its own copy of the node name (protocol_name), filled
--     from the tree for the steps already saved.
--  2. The foreign key fact_session_step.protocol_code -> dim_protocol_node is dropped.
-- The links inside a session (step -> session, step -> parent step) stay:
-- they only hold one session together.
-- Applied to production on 2026-09-26.

alter table fact_session_step add column if not exists protocol_name text;

update fact_session_step s
   set protocol_name = n.name
  from dim_protocol_node n
 where n.code = s.protocol_code
   and s.protocol_name is null;

alter table fact_session_step drop constraint if exists fact_session_step_protocol_code_fkey;
