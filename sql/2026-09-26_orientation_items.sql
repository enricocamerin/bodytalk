-- Orientation items from the chart — BodyTalk Protocol Navigator
-- Source: BodyTalk Protocol Chart ("Advanced BodyTalk … Exploring Proc…" sheet),
-- Orientation box, from the owner's photo, 2026-09-26. Wording copied as printed,
-- in the chart's order. Each entry gets its + in the Orientation tab.
-- Applied to production on 2026-09-26.

insert into dim_protocol_node (code, parent_code, name, level, sort_order, sources) values
('12.1','12','Time',2,1,'BodyTalk Protocol Chart, Orientation box (owner''s photo, 2026-09-26).'),
('12.2','12','Person',2,2,'BodyTalk Protocol Chart, Orientation box (owner''s photo, 2026-09-26).'),
('12.3','12','Place',2,3,'BodyTalk Protocol Chart, Orientation box (owner''s photo, 2026-09-26).'),
('12.4','12','Object',2,4,'BodyTalk Protocol Chart, Orientation box (owner''s photo, 2026-09-26).'),
('12.5','12','Activity',2,5,'BodyTalk Protocol Chart, Orientation box (owner''s photo, 2026-09-26).'),
('12.6','12','Event',2,6,'BodyTalk Protocol Chart, Orientation box (owner''s photo, 2026-09-26).'),
('12.7','12','Animal',2,7,'BodyTalk Protocol Chart, Orientation box (owner''s photo, 2026-09-26).'),
('12.8','12','Plant',2,8,'BodyTalk Protocol Chart, Orientation box (owner''s photo, 2026-09-26).'),
('12.9','12','Work',2,9,'BodyTalk Protocol Chart, Orientation box (owner''s photo, 2026-09-26).'),
('12.10','12','Money',2,10,'BodyTalk Protocol Chart, Orientation box (owner''s photo, 2026-09-26).'),
('12.11','12','Emotions',2,11,'BodyTalk Protocol Chart, Orientation box (owner''s photo, 2026-09-26).')
on conflict (code) do update set name=excluded.name, sort_order=excluded.sort_order, sources=excluded.sources;

update dim_qualifier_set set note = null, show_empty = false where code = '12';
update dim_protocol_node set sources = 'BodyTalk Protocol Chart, Orientation box (owner''s photo, 2026-09-26).' where code = '12';
