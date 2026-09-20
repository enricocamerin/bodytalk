-- Section 1 > Brain (1.10) — BodyTalk Protocol Navigator
-- Adds the Brain box under Section 1: 46 nodes, 39 dim_nervous_system rows (BR.*),
-- 39 empty dim_note rows (CHART.*) for the PaRama chart wording, and 78 links.
-- Anatomy/Function text is written from cited public sources (OpenStax, StatPearls,
-- and the papers named in each row). Chart wording is NOT included here: fill the
-- dim_note bodies with sql/brain-chart-notes-fill-in.sql.
-- Applied to production on 2026-09-20.

-- 1. Protocol nodes -----------------------------------------------------------
insert into dim_protocol_node (code, parent_code, name, level, sort_order, child_tab_label) values
('1.10','1','Brain',2,null,'Regions'),
('1.10.1','1.10','Cerebral Cortex',3,1,null),
('1.10.1.1','1.10.1','Frontal Lobe (17)',4,1,null),
('1.10.1.2','1.10.1','Pre-Frontal Cortex (18)',4,2,null),
('1.10.1.3','1.10.1','Parietal Lobe (19)',4,3,null),
('1.10.1.4','1.10.1','Occipital Lobe (20)',4,4,null),
('1.10.1.5','1.10.1','Temporal Lobe (21)',4,5,null),
('1.10.1.6','1.10.1','Corpus Callosum (15)',4,6,null),
('1.10.2','1.10','Limbic System',3,2,null),
('1.10.2.1','1.10.2','Cingulate Gyrus (16)',4,1,null),
('1.10.2.2','1.10.2','Septal Region (27)',4,2,null),
('1.10.2.3','1.10.2','Mammillary Bodies (25)',4,3,null),
('1.10.2.4','1.10.2','Amygdala (3)',4,4,null),
('1.10.2.5','1.10.2','Hippocampus (23)',4,5,null),
('1.10.3','1.10','Basal Ganglia',3,3,null),
('1.10.3.1','1.10.3','Caudate Nucleus (8, 9)',4,1,null),
('1.10.3.2','1.10.3','Putamen (7)',4,2,null),
('1.10.3.3','1.10.3','Globus Pallidus (5)',4,3,null),
('1.10.3.4','1.10.3','Subthalamic Nucleus (4)',4,4,null),
('1.10.3.5','1.10.3','Substantia Nigra (6)',4,5,null),
('1.10.4','1.10','Diencephalon',3,4,null),
('1.10.4.1','1.10.4','Thalamus (1)',4,1,'Nuclei'),
('1.10.4.2','1.10.4','Hypothalamus (2)',4,2,null),
('1.10.5','1.10','Brain Stem',3,5,null),
('1.10.5.1','1.10.5','Brain Stem — overall (12)',4,1,null),
('1.10.5.2','1.10.5','Midbrain (14)',4,2,null),
('1.10.5.3','1.10.5','Pons (11)',4,3,null),
('1.10.5.4','1.10.5','Medulla (13)',4,4,null),
('1.10.6','1.10','Cerebellum',3,6,null),
('1.10.6.1','1.10.6','Cerebellum (10)',4,1,null),
('1.10.4.1.1','1.10.4.1','Pulvinar (T1)',5,1,null),
('1.10.4.1.2','1.10.4.1','Lateral Geniculate Body (T2)',5,2,null),
('1.10.4.1.3','1.10.4.1','Lateral Dorsal (T3)',5,3,null),
('1.10.4.1.4','1.10.4.1','Ventral Anterior (T4)',5,4,null),
('1.10.4.1.5','1.10.4.1','Anterior Nuclear Group (T5)',5,5,null),
('1.10.4.1.6','1.10.4.1','Medial Geniculate Body (T6)',5,6,null),
('1.10.4.1.7','1.10.4.1','Centromedian (T7)',5,7,null),
('1.10.4.1.8','1.10.4.1','Reticular Nucleus (T8)',5,8,null),
('1.10.4.1.9','1.10.4.1','Intralaminar Nuclear Group (T9)',5,9,null),
('1.10.4.1.10','1.10.4.1','Lateral Posterior (T10)',5,10,null),
('1.10.4.1.11','1.10.4.1','Ventral Lateral (T11)',5,11,null),
('1.10.4.1.12','1.10.4.1','Ventral Postero-Medial (T12)',5,12,null),
('1.10.4.1.13','1.10.4.1','Midline Nuclei (T13)',5,13,null),
('1.10.4.1.14','1.10.4.1','Medial Dorsal (T14)',5,14,null),
('1.10.4.1.15','1.10.4.1','Ventral Postero-Lateral (T15)',5,15,null),
('1.10.4.1.16','1.10.4.1','Ventral Intermedial (T16)',5,16,null);

-- 2. Structure details (sourced text) -----------------------------------------
insert into dim_nervous_system (code, category, name, anatomy, function, sources) values
('BR.17','Brain — Cortex','Frontal Lobe','Chart no. 17. Anterior lobe of each hemisphere, in front of the central sulcus; contains the precentral gyrus, premotor area, frontal eye fields and Broca area.','Primary motor cortex in the precentral gyrus commands skeletal muscle through the spinal cord. The premotor area plans movements and the frontal eye fields drive eye movement and attention to visual stimuli; Broca area produces speech and in most people sits on the left only. 2023 (Nature): the classic motor homunculus is not continuous — foot, hand and mouth zones alternate with regions of a separate action-control network; parts of this reading are disputed by other labs.','OpenStax, Anatomy & Physiology 13.2; Gordon et al., Nature 617:351-359 (2023)'),
('BR.18','Brain — Cortex','Pre-Frontal Cortex','Chart no. 18. Most anterior part of the frontal lobe.','Supports cognitive functions that can underlie personality, short-term memory and consciousness. Reciprocally connected with the mediodorsal thalamus (T14), its partner for executive control (Neuron review, 2024).','OpenStax, Anatomy & Physiology 13.2; Neuron (2024), The mediodorsal thalamus in executive control'),
('BR.19','Brain — Cortex','Parietal Lobe','Chart no. 19. Lobe behind the central sulcus; contains the postcentral gyrus.','Primary somatosensory cortex (Brodmann areas 1-3): touch, pressure, tickle, pain, itch and vibration, plus the sense of body position and movement. Also contributes to processing complex visual information.','OpenStax, Anatomy & Physiology 13.2'),
('BR.20','Brain — Cortex','Occipital Lobe','Chart no. 20. Posterior lobe of each hemisphere.','Primary visual perception (Brodmann areas 17 and 18), on visual input relayed by the lateral geniculate nucleus (T2).','OpenStax, Anatomy & Physiology 13.2; StatPearls, Neuroanatomy: Thalamic Nuclei (NBK549908)'),
('BR.21','Brain — Cortex','Temporal Lobe','Chart no. 21. Lateral and inferior lobe below the lateral sulcus; holds the hippocampus and amygdala on its medial side.','Primary hearing in Brodmann areas 41-42, on input relayed by the medial geniculate nucleus (T6). Its limbic parts establish long-term memories, which are largely stored where the original sensation was processed.','OpenStax, Anatomy & Physiology 13.2; StatPearls, Neuroanatomy: Thalamic Nuclei (NBK549908)'),
('BR.15','Brain — Cortex','Corpus Callosum','Chart no. 15. Broad white-matter commissure arching under the cingulate gyrus.','The main communication route between the two cerebral hemispheres.','OpenStax, Anatomy & Physiology 13.2'),
('BR.16','Brain — Limbic','Cingulate Gyrus','Chart no. 16. Paired gyrus on the medial surface of each hemisphere, above the corpus callosum.','Limbic structure connected with reward centres, the amygdala, lateral prefrontal and parietal cortex, motor areas, the spinal cord and the hippocampus. Its hippocampal and amygdalar links suggest roles in consolidating long-term memory and processing emotional stimuli. A node of the Papez circuit.','StatPearls, Neuroanatomy: Cingulate Cortex (NBK537077); ScienceDirect Topics: Papez circuit'),
('BR.27','Brain — Limbic','Septal Region','Chart no. 27. Small area in the medial wall of the hemisphere, in front of the anterior commissure, extending into the base of the septum pellucidum.','Receives input from the hippocampus (via the fornix), the amygdala, the ventral tegmental area and the hypothalamus. Animal work links it to reward; human clinical evidence is limited, though rage behaviour has been reported after midline strokes here. The medial septum modulates learning and memory through its projections to the hippocampus; the lateral septum has been linked to social behaviour, anxiety and fear.','ScienceDirect Topics: Septal nuclei (Elsevier); PLoS ONE / PMC3432065 (lateral septum)'),
('BR.25','Brain — Limbic','Mammillary Bodies','Chart no. 25. Paired nuclei on the underside of the hypothalamus, behind the pituitary stalk.','Core node of the Papez circuit: hippocampal fibres arrive through the fornix and are relayed to the anterior thalamic nuclei (T5) through the mammillothalamic tract. Critical for consolidating memory; lesions cause profound cognitive deficits, and damage from thiamine deficiency produces Korsakoff amnesia.','StatPearls, Neuroanatomy: Mammillary Bodies (NBK537192); ScienceDirect Topics: Papez circuit'),
('BR.3','Brain — Limbic','Amygdala','Chart no. 3. Almond-shaped group of about 13 nuclei in five functional groups, in the temporal lobe beneath the uncus.','Involved in emotion, behaviour and the formation of memories; it mediates between prefrontal-temporal association cortex and the hypothalamus.','StatPearls, Neuroanatomy: Amygdala (NBK537102); OpenStax, Anatomy & Physiology 13.2'),
('BR.23','Brain — Limbic','Hippocampus','Chart no. 23. Curved structure in the medial temporal lobe; its dentate gyrus is the site of adult neurogenesis.','With the amygdala and nearby cortex it forms long-term memories and emotional responses. 2025 (Science): dividing neural progenitor cells were identified in the dentate gyrus of adults up to age 78, confirming ongoing neuron formation, with wide variation between individuals.','OpenStax, Anatomy & Physiology 13.2; Dumitru et al., Science (2025), doi:10.1126/science.adu9575'),
('BR.8','Brain — Basal Ganglia','Caudate Nucleus (head and tail)','Chart nos. 8 and 9. Long C-shaped nucleus running from the frontal lobe back and down into the temporal lobe: head at the front, tail curving into the temporal horn.','With the putamen it forms the striatum, which receives all cortical input to the basal ganglia.','OpenStax, Anatomy & Physiology 13.2; StatPearls, Neuroanatomy: Basal Ganglia (NBK537141)'),
('BR.7','Brain — Basal Ganglia','Putamen','Chart no. 7. Lies deep beneath the anterior frontal and parietal lobes, lateral to the globus pallidus.','Part of the striatum, the input stage of the basal ganglia.','OpenStax, Anatomy & Physiology 13.2; StatPearls, Neuroanatomy: Basal Ganglia (NBK537141)'),
('BR.5','Brain — Basal Ganglia','Globus Pallidus','Chart no. 5. Sits just medial to the putamen, with an external and an internal segment.','Output stage of the basal ganglia. In the direct pathway the striatum inhibits the internal segment, which releases the thalamus from inhibition and increases cortical activity; in the indirect pathway the external segment and subthalamic nucleus keep the thalamus inhibited.','OpenStax, Anatomy & Physiology 13.2; StatPearls, Neuroanatomy: Basal Ganglia (NBK537141)'),
('BR.4','Brain — Basal Ganglia','Subthalamic Nucleus','Chart no. 4. In the subthalamus, just below the thalamus.','Relay in the indirect pathway; sends excitatory glutamate projections to the internal globus pallidus and the substantia nigra.','StatPearls, Neuroanatomy: Basal Ganglia (NBK537141); OpenStax, Anatomy & Physiology 13.2'),
('BR.6','Brain — Basal Ganglia','Substantia Nigra','Chart no. 6. Midbrain nucleus with a pars compacta and a pars reticulata.','The pars compacta releases dopamine into the striatum and acts as the switch between the direct and indirect pathways; loss of these dopamine neurons causes Parkinson disease.','OpenStax, Anatomy & Physiology 13.2; StatPearls, Neuroanatomy: Basal Ganglia (NBK537141)'),
('BR.1','Brain — Diencephalon','Thalamus','Chart no. 1. Paired egg-shaped mass of about 60 nuclei at the centre of the brain, arranged in anterior, medial and lateral groups by the internal medullary lamina, plus midline and reticular nuclei.','Every sense except smell passes through it on the way to the cortex, and it processes that information rather than only relaying it. See the nuclei below for the individual relays.','OpenStax, Anatomy & Physiology 13.2; StatPearls, Neuroanatomy: Thalamic Nuclei (NBK549908)'),
('BR.2','Brain — Diencephalon','Hypothalamus','Chart no. 2. Below the thalamus, above the pituitary; includes the mammillary bodies on its underside.','Regulates homeostasis and directs the autonomic and endocrine systems through the anterior pituitary; parts of it take part in memory and emotion. 2025 (Nature): the HYPOMAP atlas charted over 450 human cell types here, in the region controlling sleep, body temperature, hunger and thirst, and showed human-mouse differences relevant to obesity drugs.','OpenStax, Anatomy & Physiology 13.2; Tadross et al., Nature (2025), doi:10.1038/s41586-024-08504-8'),
('BR.12','Brain — Brainstem','Brain Stem (overall)','Chart no. 12. Midbrain, pons and medulla, continuous with the spinal cord.','Carries the main ascending and descending pathways, connects the cranial nerves, and holds the reticular formation. 2024 (Sci Transl Med): a wakefulness network with nodes in the brain stem, hypothalamus, thalamus and basal forebrain was mapped in human brains and linked to the cortical default mode network.','OpenStax, Anatomy & Physiology 13.2; Edlow et al., Sci Transl Med 16(745) 2024'),
('BR.14','Brain — Brainstem','Midbrain','Chart no. 14. Upper brain stem: tectum with superior and inferior colliculi, and tegmentum with the substantia nigra and ventral tegmental area.','The superior colliculus combines visual, auditory and body-space information to orient the eyes; the inferior colliculus belongs to the hearing pathway. The dopaminergic ventral tegmental area is the hub linking the wakefulness network to the cortical default mode network (2024).','OpenStax, Anatomy & Physiology 13.2; Edlow et al., Sci Transl Med 16(745) 2024'),
('BR.11','Brain — Brainstem','Pons','Chart no. 11. Bulging middle part of the brain stem, connected to the cerebellum by thick peduncles.','The main connection between brain stem and cerebellum, passing descending forebrain input on to it; with the medulla it regulates heart and breathing rates.','OpenStax, Anatomy & Physiology 13.2'),
('BR.13','Brain — Brainstem','Medulla','Chart no. 13. Lowest part of the brain stem, continuous with the spinal cord.','Its outer white matter continues the spinal pathways and its grey matter processes cranial nerve information; the reticular formation running through it relates to sleep, wakefulness and attention.','OpenStax, Anatomy & Physiology 13.2'),
('BR.10','Brain — Cerebellum','Cerebellum','Chart no. 10. Behind the brain stem in the posterior fossa; anterior and posterior lobes plus the vermis. About 10 percent of brain mass.','Compares the cerebrum motor commands with sensory feedback and issues corrections when a movement is off. The anterior lobe handles mainly sensorimotor processing; the posterior lobe supports cognition and emotion, and its damage causes the cerebellar cognitive affective syndrome (executive, visuospatial, language and affect regulation deficits).','OpenStax, Anatomy & Physiology 13.2; Schmahmann, Neurosci Lett (2019), The cerebellum and cognition'),
('BR.T1','Brain — Thalamic nuclei','Pulvinar','Thalamus panel no. 1. Largest thalamic nucleus, at the back of the thalamus above the geniculate bodies.','Strongly connected with visual cortex and part of the visual attention network; visual salience is likely one of its main functions, and one-sided damage causes neglect of the opposite side of space. A 2023 review describes it as a hub for attentional modulation, feature binding and predictive coding.','Neurology (2015), doi:10.1212/WNL.0000000000001276; Trends in Neurosciences (2023), The pulvinar as a hub of visual processing'),
('BR.T2','Brain — Thalamic nuclei','Lateral Geniculate Body','Thalamus panel no. 2. Small body on the underside of the pulvinar, lateral to the medial geniculate.','Receives the optic tracts and relays vision to the primary visual cortex of the occipital lobe.','StatPearls, Neuroanatomy: Thalamic Nuclei (NBK549908)'),
('BR.T3','Brain — Thalamic nuclei','Lateral Dorsal','Thalamus panel no. 3. Dorsal tier of the lateral nuclear group.','Relay nucleus of the lateral group; its specific function is not detailed in the sources used here.','StatPearls, Neuroanatomy: Thalamic Nuclei (NBK549908)'),
('BR.T4','Brain — Thalamic nuclei','Ventral Anterior','Thalamus panel no. 4. Front of the ventral tier of the lateral group.','Part of the lateral nuclear group; its specific function is not detailed in the sources used here.','StatPearls, Neuroanatomy: Thalamic Nuclei (NBK549908)'),
('BR.T5','Brain — Thalamic nuclei','Anterior Nuclear Group','Thalamus panel no. 5. Front of the thalamus, enclosed by the fork of the internal medullary lamina.','Receives the mammillothalamic tract from the mammillary bodies as part of the Papez circuit and is considered critical for episodic memory in humans.','StatPearls, Neuroanatomy: Mammillary Bodies (NBK537192); ScienceDirect Topics: Papez circuit'),
('BR.T6','Brain — Thalamic nuclei','Medial Geniculate Body','Thalamus panel no. 6. Small body medial to the lateral geniculate, under the pulvinar.','Relays hearing from the superior olive and inferior colliculus to the auditory cortex of the temporal lobe.','StatPearls, Neuroanatomy: Thalamic Nuclei (NBK549908)'),
('BR.T7','Brain — Thalamic nuclei','Centromedian','Thalamus panel no. 7. One of the caudal intralaminar nuclei, inside the internal medullary lamina.','Belongs to the intralaminar group; its specific function is not detailed in the sources used here.','StatPearls, Neuroanatomy: Thalamic Nuclei (NBK549908)'),
('BR.T8','Brain — Thalamic nuclei','Reticular Nucleus','Thalamus panel no. 8. Thin shell of neurons wrapping the lateral surface of the thalamus.','Projects back onto the thalamus rather than to the cortex and regulates its activity; fed by the reticular activating system and basal forebrain, which gives the thalamus a role in alertness and attention.','StatPearls, Neuroanatomy: Thalamic Nuclei (NBK549908)'),
('BR.T9','Brain — Thalamic nuclei','Intralaminar Nuclear Group','Thalamus panel no. 9. Nuclei lying within the internal medullary lamina.','Take input from the basal ganglia and project to the cortex. The central medial nucleus of this group handles alertness, motor information, consciousness and awareness.','StatPearls, Neuroanatomy: Thalamic Nuclei (NBK549908)'),
('BR.T10','Brain — Thalamic nuclei','Lateral Posterior','Thalamus panel no. 10. Dorsal tier of the lateral group, in front of the pulvinar.','Relay nucleus of the lateral group; its specific function is not detailed in the sources used here.','StatPearls, Neuroanatomy: Thalamic Nuclei (NBK549908)'),
('BR.T11','Brain — Thalamic nuclei','Ventral Lateral','Thalamus panel no. 11. Ventral tier of the lateral group, behind the ventral anterior nucleus.','Receives input from the cerebellum and basal ganglia and sends motor information to the motor cortex.','StatPearls, Neuroanatomy: Thalamic Nuclei (NBK549908)'),
('BR.T12','Brain — Thalamic nuclei','Ventral Postero-Medial (VPM)','Thalamus panel no. 12. Ventral tier, medial to the VPL.','Relays facial sensation and taste to the somatosensory cortex.','StatPearls, Neuroanatomy: Thalamic Nuclei (NBK549908)'),
('BR.T13','Brain — Thalamic nuclei','Midline Nuclei','Thalamus panel no. 13. Thin nuclei along the wall of the third ventricle, including the paraventricular, parataenial and rhomboid nuclei.','Their functions are not detailed in the sources used here.','StatPearls, Neuroanatomy: Thalamic Nuclei (NBK549908)'),
('BR.T14','Brain — Thalamic nuclei','Medial Dorsal (Mediodorsal)','Thalamus panel no. 14. Large nucleus medial to the internal medullary lamina.','Reciprocally connected with every area of the prefrontal cortex; a 2024 review assigns it a specific role in executive control, and it is causally involved in fast learning, working memory and adaptive decision-making in primates and rodents.','Neuron (2024), The mediodorsal thalamus in executive control; Ouhaz, Fleming & Mitchell, Front Neurosci (2018)'),
('BR.T15','Brain — Thalamic nuclei','Ventral Postero-Lateral (VPL)','Thalamus panel no. 15. Ventral tier, lateral to the VPM.','Relays body temperature and pain, vibration, pressure, fine touch and proprioception to the somatosensory cortex.','StatPearls, Neuroanatomy: Thalamic Nuclei (NBK549908)'),
('BR.T16','Brain — Thalamic nuclei','Ventral Intermedial','Thalamus panel no. 16. Ventral tier of the lateral group.','Not covered in the sources used here.','(no source found in the references used for this box)');

-- 3. Links: nodes -> structure details ----------------------------------------
insert into protocol_dimension_link (protocol_code, dimension_table, dimension_code) values
('1.10.1.1','dim_nervous_system','BR.17'),('1.10.1.2','dim_nervous_system','BR.18'),
('1.10.1.3','dim_nervous_system','BR.19'),('1.10.1.4','dim_nervous_system','BR.20'),
('1.10.1.5','dim_nervous_system','BR.21'),('1.10.1.6','dim_nervous_system','BR.15'),
('1.10.2.1','dim_nervous_system','BR.16'),('1.10.2.2','dim_nervous_system','BR.27'),
('1.10.2.3','dim_nervous_system','BR.25'),('1.10.2.4','dim_nervous_system','BR.3'),
('1.10.2.5','dim_nervous_system','BR.23'),('1.10.3.1','dim_nervous_system','BR.8'),
('1.10.3.2','dim_nervous_system','BR.7'),('1.10.3.3','dim_nervous_system','BR.5'),
('1.10.3.4','dim_nervous_system','BR.4'),('1.10.3.5','dim_nervous_system','BR.6'),
('1.10.4.1','dim_nervous_system','BR.1'),('1.10.4.2','dim_nervous_system','BR.2'),
('1.10.5.1','dim_nervous_system','BR.12'),('1.10.5.2','dim_nervous_system','BR.14'),
('1.10.5.3','dim_nervous_system','BR.11'),('1.10.5.4','dim_nervous_system','BR.13'),
('1.10.6.1','dim_nervous_system','BR.10'),
('1.10.4.1.1','dim_nervous_system','BR.T1'),('1.10.4.1.2','dim_nervous_system','BR.T2'),
('1.10.4.1.3','dim_nervous_system','BR.T3'),('1.10.4.1.4','dim_nervous_system','BR.T4'),
('1.10.4.1.5','dim_nervous_system','BR.T5'),('1.10.4.1.6','dim_nervous_system','BR.T6'),
('1.10.4.1.7','dim_nervous_system','BR.T7'),('1.10.4.1.8','dim_nervous_system','BR.T8'),
('1.10.4.1.9','dim_nervous_system','BR.T9'),('1.10.4.1.10','dim_nervous_system','BR.T10'),
('1.10.4.1.11','dim_nervous_system','BR.T11'),('1.10.4.1.12','dim_nervous_system','BR.T12'),
('1.10.4.1.13','dim_nervous_system','BR.T13'),('1.10.4.1.14','dim_nervous_system','BR.T14'),
('1.10.4.1.15','dim_nervous_system','BR.T15'),('1.10.4.1.16','dim_nervous_system','BR.T16');

-- 4. Empty chart-text notes, derived from the rows above, and their links ------
insert into dim_note (code, title, body, page_ref, sources)
select replace(d.code,'BR.','CHART.'),
       d.name || ' — chart text',
       null,
       'PaRama Brain Psychology and Physiology chart (IBA), incl. Thalamus panel',
       'Transcribed from the IBA PaRama chart by Enrico under his IBA digitisation mandate. Verbatim chart wording; not part of the sourced Anatomy/Function text.'
from dim_nervous_system d
where d.code like 'BR.%';

insert into protocol_dimension_link (protocol_code, dimension_table, dimension_code)
select l.protocol_code, 'dim_note', replace(l.dimension_code,'BR.','CHART.')
from protocol_dimension_link l
where l.protocol_code like '1.10%' and l.dimension_table = 'dim_nervous_system';
