-- Workbook: lesson ranges in the Part II labels — BodyTalk Protocol Navigator
-- Owner's report (2026-09-26): in ACIM › Workbook "the lessons stop at 200;
-- 301–365 are missing". They were there, inside Part II, whose groups follow
-- acim.org's names ("9. What Is the Second Coming? (301–310)"), so the lessons
-- were hard to find. The labels now lead with the lesson range; the official
-- title follows unchanged. Ranges are the ones acim.org prints in each title.
--  * Part I → "Part I · Lessons 1 to 220", Part II → "Part II · Lessons 221 to 365"
--  * each Part II group "N. Title (a–b)" → "Lessons a to b · N. Title";
--    "Final Lessons (361–365)" → "Lessons 361 to 365 · Final Lessons".
-- Also removes lessons 301–365 that were added by mistake under BodyTalk ›
-- Forgiveness › Workbook › 300 (10.1.3.301–365) earlier the same day; no saved
-- session used them.
-- Applied to production on 2026-09-26.

update dim_protocol_node set name = 'Part I · Lessons 1 to 220'    where code = 'ACIM.2.2' and name = 'Part I';
update dim_protocol_node set name = 'Part II · Lessons 221 to 365' where code = 'ACIM.2.3' and name = 'Part II';

update dim_protocol_node
   set name = 'Lessons ' || m[2] || ' to ' || m[3] || ' · ' || m[1]
  from (select code c, regexp_match(name, '^(.*) \((\d+)–(\d+)\)$') m
          from dim_protocol_node where parent_code = 'ACIM.2.3') x
 where code = x.c and x.m is not null;

delete from dim_protocol_node where parent_code = '10.1.3' and code ~ '^10\.1\.3\.(3[0-6][0-9])$';
