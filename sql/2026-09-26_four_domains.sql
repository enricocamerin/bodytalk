-- Home page with four domains — BodyTalk Protocol Navigator
-- Owner's request (2026-09-26): the home page shows four boxes, ACIM, BodyTalk,
-- Healing Code and Access. BodyTalk holds the protocol exactly as before (its
-- nodes keep their numeric codes; the app places the numeric level-1 nodes
-- inside the "BT" domain). ACIM holds four books. Healing Code and Access are
-- empty until the owner supplies their content.
-- Names are the owner's wording; the ACIM book titles follow the Foundation
-- for Inner Peace edition already cited in dim_acim_lesson.sources
-- ("A Course in Miracles, Workbook for Students").
-- Chapter lists and the links to the originals are NOT here yet: acim.org
-- could not be reached from the build environment, and titles are not written
-- from memory. They go in a later file, with link_url and sources per row.
-- Applied to production on 2026-09-26.

alter table dim_protocol_node add column if not exists link_url text;
alter table dim_protocol_node add column if not exists sources  text;

insert into dim_protocol_node (code, parent_code, name, level, sort_order, child_tab_label) values
('ACIM',   null,'ACIM',                   1,0,'Books'),
('BT',     null,'BodyTalk',               1,1,null),
('HC',     null,'Healing Code',           1,2,null),
('ACCESS', null,'Access',                 1,3,null),
('ACIM.1','ACIM','Text',                  2,1,'Chapters'),
('ACIM.2','ACIM','Workbook for Students', 2,2,'Lessons'),
('ACIM.3','ACIM','Manual for Teachers',   2,3,'Sections'),
('ACIM.4','ACIM','The Song of Prayer',    2,4,'Chapters')
on conflict (code) do nothing;
