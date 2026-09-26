-- Item tabs from the chart: Orientation, Definition, Subsession — BodyTalk Protocol Navigator
-- Owner's request (2026-09-26): "to the right of Orientation add Definition and
-- Subsession; in Definition put the contents of the photo".
-- Source: BodyTalk Protocol Chart, "Item" box (Details: More Specific,
-- Orientation, Definition, Subsession) and its "Definition" box, from the
-- owner's photo of the chart, 2026-09-26. Wording copied as printed.
-- The last Definition entry is cut at the photo's right edge ("Other System…");
-- it is entered as visible and flagged for the owner to confirm.
--  * dim_qualifier_set gains sort_order: the tabs follow the chart order.
--  * Definition (13) with its six entries; Subsession (14) empty until the owner
--    gives its contents. Both show on every BodyTalk node.
-- Applied to production on 2026-09-26.

alter table dim_qualifier_set add column if not exists sort_order int;

update dim_qualifier_set set sort_order = 1 where code = '12';  -- Orientation
update dim_qualifier_set set sort_order = 1 where code = '11';  -- Tentacle (Section 3, in Orientation's place)
update dim_qualifier_set set sort_order = 9 where code = '8';   -- Emotion

insert into dim_protocol_node (code, parent_code, name, level, sort_order, child_tab_label, sources) values
('13',   null, 'Definition',        1, 13, null, 'BodyTalk Protocol Chart, Item box (owner''s photo, 2026-09-26).'),
('13.1', '13', 'Consciousness',     2, 1,  null, 'BodyTalk Protocol Chart, Definition box (owner''s photo, 2026-09-26).'),
('13.2', '13', 'Physiology',        2, 2,  null, 'BodyTalk Protocol Chart, Definition box (owner''s photo, 2026-09-26).'),
('13.3', '13', 'Emotions',          2, 3,  null, 'BodyTalk Protocol Chart, Definition box (owner''s photo, 2026-09-26).'),
('13.4', '13', '5 Elements',        2, 4,  null, 'BodyTalk Protocol Chart, Definition box (owner''s photo, 2026-09-26).'),
('13.5', '13', '5 Senses',          2, 5,  null, 'BodyTalk Protocol Chart, Definition box (owner''s photo, 2026-09-26).'),
('13.6', '13', 'Other System',      2, 6,  null, 'BodyTalk Protocol Chart, Definition box (owner''s photo, 2026-09-26); the word is cut at the photo''s edge, to be confirmed by the owner.'),
('14',   null, 'Subsession',        1, 14, null, 'BodyTalk Protocol Chart, Item box (owner''s photo, 2026-09-26).')
on conflict (code) do nothing;

insert into dim_qualifier_set (code, label, note, sort_order, show_empty) values
('13', 'Definition', null, 2, false),
('14', 'Subsession', 'Awaiting the Subsession contents from the BodyTalk Protocol Chart. Deliberately empty rather than invented.', 3, true)
on conflict (code) do update set label=excluded.label, note=excluded.note, sort_order=excluded.sort_order, show_empty=excluded.show_empty;
