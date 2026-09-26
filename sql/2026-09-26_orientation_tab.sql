-- Qualifier tabs by section: Tentacle only in Section 3, Orientation elsewhere — BodyTalk Protocol Navigator
-- Owner's request (2026-09-26): "Tentacle must appear only in Section 3; add
-- Orientation instead of Tentacle."
--  * dim_qualifier_set gains only_under / not_under (a protocol code: the tab
--    shows on that node and everything below it, or everywhere but there) and
--    show_empty (show the tab even before it has items, with its note).
--  * Tentacle (11) shows only under 3 (Section 3 — Matrixes).
--  * Orientation (12) is a new qualifier set shown everywhere except Section 3.
--    Its items come from the BodyTalk Protocol Chart and are entered by the
--    owner; it is deliberately empty until then (nothing invented).
-- Qualifier tabs show on BodyTalk nodes only (not on ACIM, Healing Code, Access).
-- Applied to production on 2026-09-26.

alter table dim_qualifier_set add column if not exists only_under text;
alter table dim_qualifier_set add column if not exists not_under  text;
alter table dim_qualifier_set add column if not exists show_empty boolean not null default false;

update dim_qualifier_set set only_under='3' where code='11';

insert into dim_protocol_node (code, parent_code, name, level, sort_order, child_tab_label)
values ('12', null, 'Orientation', 1, 12, null)
on conflict (code) do nothing;

insert into dim_qualifier_set (code, label, note, not_under, show_empty)
values ('12', 'Orientation',
        'Awaiting the Orientation list from the BodyTalk Protocol Chart. Deliberately empty rather than invented.',
        '3', true)
on conflict (code) do update set label=excluded.label, note=excluded.note,
  not_under=excluded.not_under, show_empty=excluded.show_empty;
