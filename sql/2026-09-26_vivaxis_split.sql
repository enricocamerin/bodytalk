-- Section 2 > Vivaxis > 2.2.1 "Birth / Environmental / Body" — BodyTalk Protocol Navigator
-- The node held three items in one name. They become three child nodes, each with
-- its own + in the app. The names are the owner's existing wording, split at "/";
-- nothing new is written. 2.2.1 stays as the group that holds them (owner's choice).
-- In production on 2026-09-26.

insert into dim_protocol_node (code, parent_code, name, level, sort_order, child_tab_label) values
('2.2.1.1','2.2.1','Birth',4,1,null),
('2.2.1.2','2.2.1','Environmental',4,2,null),
('2.2.1.3','2.2.1','Body',4,3,null)
on conflict (code) do nothing;
