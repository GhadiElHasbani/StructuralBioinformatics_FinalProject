# Structural Bioinformatics (BIF435) - Final Project
## A δ-Opioid Receptor Theoretical Model
### This document details the integrative modeling process of the full δ-opioid receptor in its unbound state as well as the iterative loop building and refinement process in the presence of the target ligand, dermorphin.

# Ghadi, GEH, El Hasbani
### Computer Science and Mathematics Department, Lebanese American University, Byblos, ghadi.elhasbani@lau.edu
# Rawan, RT, Tohme
### Computer Science and Mathematics Department, Lebanese American University, Byblos, rawan.tohme@lau.edu

## ABSTRACT
With the increase in availability of experimentally determined transmembrane protein structures, especially ligand-bound G-Protein Couped Receptors (GPCRs), there is an increased need for integrative models that attempt to combine existing experimental and theoretical evidence into a comprehensive, ligand-specific model. This is especially considering the difficulty to dock peptides into loop-filled binding sites of full sequence models. Using RosettaCM, a first draft of an integrative model of the full delta-opioid 7-pass transmembrane GPCR (DOR) in its unbound state is presented. A previously described iterative procedure combining RosettaCM (a second iteration) and FlexPepDock (before and after RosettaCM) was used to then rebuild the binding site in the presence of a peptide (dermorphin, n=7) previously shown to have analgesic properties and decreased addictive potential. The resulting models are then assessed for quality, compared, and aligned, and the final peptide-bound conformations are clustered. In conclusion, the first draft modeling process was successful in generating reliable theoretical, integrative models specific to dermorphin, although future improvements are needed.

**CCS CONCEPTS** • integrative modeling • delta-opioid receptor • dermorphin • iterative modeling • G-protein coupled receptor

**Additional Keywords and Phrases**: GPCR, comparative modeling, complex modeling, refinement, clustering, 7-pass transmembrane receptor, theoretical modeling

## 1	INTRODUCTION
Opioid receptors (OR) are part of the class A of G-protein coupled receptors (GPCRs) that are the target for opiates, some of the most potent analgesic compounds in clinical usage. This is because opiates are among the most powerful pain relievers. However, their therapeutic efficacy may be restricted since long-term usage might lead to tolerance to analgesic effects, necessitating higher doses, which can cause side effects such as depression (Allouche et al., 2014). The three well-defined opioid receptors (ORs) in the superfamily of GPCRs are Mu opioid receptors (MORs), delta-opioid receptors (DORs), and kappa opioid receptors (KORs). They are widely distributed in the nervous system (Fine & Russel, 2004). All ORs have the same general structure with a glycosylated extracellular N-terminus, palmitoylated intracellular C-terminus, seven transmembrane (TM) alpha helices connected by three extracellular loops i.e. extracellular loop1 (EL1), extracellular loop2 (EL2), extracellular loop3 (EL3) and three intracellular loops namely intracellular loop1 (IL1), intracellular loop2 (IL2) and intracellular loop3 (IL3) (Patra et al., 2012). The ligands for these receptors are opioids (Fine & Russel, 2004), of which there are many types classified into endogenous, as endorphins and endomorphins, and exogenous opioids, as morphine, heroin and dermorphin (Peterson et al., 2021). Morphine and dermorphin have a considerably higher affinity for MORs than for other ORs. Like MOR agonists, they produce antinociception and also catalepsy, respiratory depression, constipation, tolerance, and dependence, although at a lower degree than morphine does (Negri et al., 2013). Selective activation of the DORs has great potential for the treatment of chronic pain (Ruff & Kieffer, 2011) with ancillary anxiolytic- and antidepressant-like effects (Chung & Kieffer, 2013). Their ability to cause emotional responses is highly desirable because of the frequent association of anxiety and mood disorders with chronic pain (Goldenberg, 2010). Compared to MOR agonists, molecules acting on DOR typically show reduced adverse effects. Dermorphin (sequence: YAFGYPS), which has a D-ALA in position 2, is 30–40 times more powerful than morphine, although it is thought to be less prone to cause tolerance and addiction (Broccardo et al., 1981). One of the challenges with docking peptides is that their conformations are too flexible to be sampled and need to be reliably modeled with specialized tools. Another challenge is that peptides are large and might not be able to be docked on the full receptor structure due to loops often collapsing into the binding site through modeling of the receptor (Bender et al., 2019). Docking studies have been performed with deltorphins (segment 48-54 of Dermorphin-1; PDB ID: P05422) and ORs (see Ślusarez, 2011 for DOR and MOR), or YGGFMKKKFMRFamide (YFa; Vats et al., 2008), a chimeric opioid peptide, and ORs (see Patra et al., 2012 for KOR) whereby homology or comparative modeling is used and possibly combined with iterative minimization or refinement to yield ligand-specific structures. Moreover, several iterative protocols have been described for receptor peptide docking and GPCR structure prediction. For example, the Rosetta-MD protocol combines iterative molecular dynamics (MD) simulations with Rosetta membrane protein structure prediction (Rohl et al., 2004) guided by cryo-EM experimental data (Leelananda & Lindert, 2017). Another protocol uses Rosetta FlexPepDock (London et al., 2011) ab-initio to model the receptor binding site with a given peptide of unknown structure (Raveh et al., 2011). Yet another approach combines CABS-dock (Kurcinski et al., 2020), PD2 backbone modeling, and FlexPepDock refinement to dock fully flexible peptides (Badaczewska-Dawid et al., 2021). These methods provide an experimentally-guided framework for refining a receptor binding site with specificity to a peptide. Nevertheless, the only integrative model available on PDB-Dev (Burley et al., 2017; accessible at https://pdb-dev.wwpdb.org/) to date is that of ghrelin bound to its growth hormone secretagogue receptor (GHSR; PDB-Dev ID: PDBDEV_00000024; Bender et al., 2019). This model was generated using an 3 iterations of a procedure combining RosettaCM (Song et al., 2013) and FlexPepDock to rebuild the loops to accommodate ghrelin. Although this model combined NMR data, the computational protocol can be adapted to be independent of biological data for time and accessibility constraints. To the authors’ knowledge, no study has been conducted to date that combines integrative modeling and peptide docking to generate a peptide-specific complex model of ORs and dermorphin. Therefore, due to dermorphin’s analgesic significance and to DOR’s important role, we present here a draft for a theoretical model that combines all existing X-ray diffraction models for DOR into an integrated unbound model that is then made specific to dermorphin through the RosettaCM-FlexPepDock protocol which is more time-efficient as compared to protocols involving MD simulations.

## 2	MATERIALS & METHODS
The iterative model was computed using the previously described iterative procedure. The following section describes the detailed procedure, slight modifications, as well as all data used from the Protein Data Bank (PDB; Berman et al., 2000; Berman & Nakamura, 2003), AlphaFold2 (Jumper et al., 2021), and UniProt (Apweiler et al., 2004). 
### 2.1	Data
The protein sequence of DOR was obtained from UniProt (https://www.uniprot.org/peptidesearch/; Gene: OPRD1; UniProt ID: P41143) in FASTA format. For the first round of RosettaCM, the templates used (see Table 1 for detailed description) were five existing experimental (bound) structures for DOR obtained from PDB (PDB IDs: 4N6H, 4RWA, 4RWD, 6PT2, 6PT3) and one theoretical (unbound) model from AlphaFold2 (UniProt ID: P41143).The AlphaFold2 model is the only template with the full sequence, notably the N-terminus on the extracellular side. Although all experimental structures contain ligands and heteroatoms, some of which shown to have biological significance such as the role of a sodium ion (Na+) in regulating ligand binding (Fenalti et al., 2014), the PDB files were cleaned for heteroatoms, and chains “A” were selected in all structures. The clean_pdb.py script in the Rosetta package (Das & Baker, 2008) was used for this task. The sequences for each structure were used as input for ClustalOmega (Sievers & Higgins, 2014) to generate a multiple sequence alignment (MSA). The alignment was then converted to Grishin file format using aln2grishin.py script available on GitHub (https://gist.github.com/edvb/466f5b555878b67ea53dcdc7fab59d97). The .grishin files, the cleaned PDBs, and the target .fasta sequence were used as input for the threading process using the Rosetta package.
For the second iteration, the structure for Dermorphin-1 (Uniprot ID: P05422) was obtained from AlphaFold2. The structure is 197 residues long and is truncated into a 7 residue-long dermorphin peptide. Possible segments include 80-86 (used), 115-121, and 150-156 for dermorphin. All three segments have similar secondary structure corresponding to a short, slightly extended, coil.

<img width="617" alt="Screen Shot 2022-04-24 at 11 46 04 PM" src="https://user-images.githubusercontent.com/66255821/164995901-e4ea41a9-e7e3-427d-8630-76568d53e1cc.png">

### 2.2	First Iteration: Unbound DOR
The first iteration only consisted of RosettaCM using the Rosetta package (publicly available at https://www.rosettacommons.org/software/license-and-download). Modeling constraints included one disulfide bond between residues CYS 121 and CYS 128 (Figure 3). Membrane span constraints were derived using TOPCONS2 (Tsirigos et al., 2015; accessible at http://topcons.net/) since the standard tool OCTOPUS (Viklund & Elofsson, 2008; accessible at http://octopus.cbr.su.se.) was down. Nevertheless, TOPCONS2 gave a correct prediction of 7 TM regions, whereas OCTOPUS predicted 5. The TOPCONS2 output was converted to a .span constraints file using octopus2span.pl script in the Rosetta package considering that both tools have the same output format. Standard protocol was used for membrane structure prediction with FastRelax and standard membrane weight constraints (from Rosetta package) specified in a Rosetta .xml script. The protocol options were specified in a separate file where inputs including constraints, target FASTA sequence, and .xml script were specified. Options also specified 3 PDB files with their corresponding scores as output. The best structure was defined on the basis of lowest Total Rosetta Score (TRS). The best structure and the AlphaFold2 theoretical models were used to generate Protein Structure Validation Suite (PSVS; Bhattacharya et al., 2007; accessible at https://montelionelab.chem.rpi.edu/PSVS/PSVS/) reports. The outputted structures and the AlphaFold2 model were also aligned with mTM-align (Dong et al., 2018; accessible at https://yanglab.nankai.edu.cn/mTM-align/) and visualized through PyMol (DeLano, 2002; publicly available at https://pymol.org/2/).

<img width="378" alt="Screen Shot 2022-04-24 at 11 45 25 PM" src="https://user-images.githubusercontent.com/66255821/164995878-23f01bd6-b96a-483a-b718-0344d6bb8cb3.png">

## 2.3	Second Iteration: Bound DOR
The second iteration consists of four steps. In the first step, the receptor’s binding site has to be cleared of loops (residues 1-38) and the peptide has to be positioned closer to the binding site. The latter is done using any classical peptide docking server, in this case HPEPDOCK (Zhou et al., 2018; accessible at http://huanglab.phys.hust.edu.cn/hpepdock/). HPEPDOCK was also applied on the untruncated (full) model from the first iteration to contrast the position of the peptide. The second step consists of FlexPepDock refinement using the Rosetta package. This is considering that the template for the peptide exists and is not in need of ab initio modeling. For the refinement, the docked structure PDB file was first prepacked using the Rosetta package and a standard prepacking flags file, and it was specified as input in the standard refinement flags file. Output is a single refined structure PDB file with corresponding scores. The third step consisted of another round of RosettaCM to rebuild the binding site in the presence of the peptide. Modeling constraints were maintained, although residue numbering was adjusted. Full atom constraints were also added between  TYR 1 of dermorphin – TRP 172 of DOR which were seen to be in close proximity in the docked structure. This constraint will maintain dermorphin within a distance of the binding site. The templates used were all three structures generated in the first iteration as well as the AlphaFold2 model as well as the refined docked structure. A single model and its scores was generated, with full atom constraints maintained in FastRelax and the refined docked structure as native, and subsequently used as input for a second round of FlexPepDock refinement in step four. In this last step, 10 models were generated with their corresponding scores. The best structure was used to generate Protein Structure Validation Suite (PSVS; Bhattacharya et al., 2007; accessible at https://montelionelab.chem.rpi.edu/PSVS/PSVS/) reports. The outputted peptide conformations were also clustered with STRALCP (Zemla et al., 2007; accessible at http://proteinmodel.org/AS2TS/STRALCP/) and visualized through PyMol for comparison with the output of the first iteration and Chimera (Pettersen et al., 2004; accessible at https://www.cgl.ucsf.edu/chimera/download.html) for analysis of ligand binding.

<img width="388" alt="Screen Shot 2022-04-24 at 11 44 20 PM" src="https://user-images.githubusercontent.com/66255821/164995859-8f09ff0b-7453-47af-9466-62b8cb185e7f.png">
<img width="464" alt="Screen Shot 2022-04-24 at 11 44 35 PM" src="https://user-images.githubusercontent.com/66255821/164995866-b7444103-585e-4bae-99c7-2d761e50e09a.png">

## 3	RESULTS & DISCUSSION
### 3.1	Unbound DOR
The three unbound structures generated by the first iteration were filtered whereby the best model has the lowest TRS (Table 2A). On this basis, Unbound model 1 with TRS of -993.121 was selected for a PSVS report. This strategy was only employed for time contraints, whereas a large number of models would be sampled and fed to the next step. This is evident by the fact that Unbound model 2 has a score of -989.236 which is very close to that of the best model. This means that a sampling strategy would be effective to cover different acceptable conformations of the unbound receptor. For the PSVS results, The best unbound model clearly underperforms with the MolProbity clash score (4.34)  as compared to AlphaFold2 (0.00) with a higher Z-score. Although disallowed regions account for 0.6% of residues for both models, percentage of allowed residues for model 1 (91.4%) is slightly lower than that of AlphaFold2 (93.5%). This means that difference could be mainly in ambiguous regions of the Ramachandran plot and should not be quickly dismissed. We can also see from the alignment in PyMol (Figure 6: left) that AlphaFold2’s C- and N-termini are almost fully extended whereas those of all 3 RosettaCM models form secondary structures, primarily alpha helices, at the termini. This could explain the difference in clash score. Moreover, it is also obvious that most disagreement in the structures is located at the termini, which could represent true flexibility although more samples are needed to verify this. For the mTM-align results (Figure 4), model 1 is more similar to the AlphaFold2 model only when aligned without other templates in which 2 and 3 are more similar to AlphaFold2 than 1. Models 2 and 3 are also consistently more similar. Nevertheless, since other template structures are not complete and might also contain Cytochrome component, the alignment on the left of Figure 4 should be taken with caution. With this in mind, it is reasonable that model 1 is the best scoring since it is the most similar to AlphaFold2 which still outperforms it in ProCheck scores. Nevertheless, the differences between them could be key to better understanding DOR.

### Figure 6A: Best Unbound Model from PyMol
<img width="232" alt="image" src="https://user-images.githubusercontent.com/66255821/164995651-56921063-cdff-4f53-9b8d-89097873c9d0.png">

### Figure 6B: Unbound models 1-3 aligned with AlphaFold2 in pink from PyMol
<img width="217" alt="image" src="https://user-images.githubusercontent.com/66255821/164995673-f987f733-1dc1-44d3-b57d-86ee9355f211.png">

### 3.2	Bound DOR
As with the unbound structures, the 10 refined bound structures generated from the second round of Rosetta FlexPepDock refinement were filtered based on TRS (Table 2B) whereby the best model, model 5, had the lowest TRS of -350.639. All models except model 7 (TRS = 35.598) have favorable scores, but model 5 outperforms all others by at least 50 points. For this reason, only the ligand binding of this model was analyzed using Chimera. Five pairs of residues were found to be in close proximity through visualization on Chimera: TRP 216 – TYR 1, TYR 136 – TYR 1, ARG 199 – PRO 6, ASP 28 – TYR 5, PHE 209 – PHE 3 for DOR and dermorphin, respectively. The involvement of TYR 1 and TYR 5 supports previous findings (Lazarus et al., 1990) that show that these 2 TYR resides form stacking interactions as part of one component necessary for optimal binding. Although TYR 1 is in proximity to 2 aromatic residues (TRP 216 and TYR 136), TYR 5 is instead in proximity to ASP 28 which could be participating in an H-bond. A possible stacking interaction is also observed between 2 PHEs, also consistent with previous results indicating PHE 3 as part of another necessary component. Aromatic interactions seem to play a rather major role in dermorphin binding with 7/10 possibly implicated residues being aromatic. Moreover, the involvement of TRP 216 could mean that future improvements should include this residue instead in full atom constraints in the second RosettaCM iteration. This shows the incongruity between HPEPDOCK and FlexPepDock results which is also supported by Figure 8. The results of FlexPepDock (Figure 8) show that the peptide is shifted towards the Beta strands as compared to HPEPDOCK results. The conformations of dermorphin sampled seem to display dynamic movement in the binding site. Two non-discrete binding modes seem to cluster with some conformations slightly in between, possibly representing transition states. This is also supported by StralCP clustering results (Figure 5) which shows ambiguous groups that could be considered 2 or 3 clusters. Finally, MolProbity clash score (Table 3) greatly increased (21.16) while Z-score decreased (-2.11) which could indicate too many clashes in the binding site. Disallowed residues also outnumbered other models with 1.2%, whereby allowed regions constituted 88.7%. These results could indicate problematic binding, especially since loops nearby to dermorphin did not vary significantly in conformation. Nevertheless, scores are still somewhat acceptable and results seem to be biologically congruent. The protocol could be repeated and further optimized, including better constraints, better cleaning of template structures, increasing number of structures outputted and inputted at each iteration, taking into account heteroatoms such as the sodium ion, lipid and carbohydrate modifications, and D-ALA, and possibly even incorporating MD simulations and/or biological data for more accurate and reliable results. Other ligands such as morphine and endogenous opioids should also be used to further elucidate the specificities of dermorphin binding. Finally, other OR receptors or even oligomeric states of the same receptor should be investigated, considering that the oligomeric state of a receptor has been found to influence binding, even for class A GPCRs (Greife et al., 2016).

### Figure 7A: Best Bound Model from PymMol
<img width="246" alt="image" src="https://user-images.githubusercontent.com/66255821/164995723-506604a0-ad72-4b56-9282-8502dc06fc35.png">

### Figure 7B: Dermorphin stick model in dark purple
<img width="204" alt="image" src="https://user-images.githubusercontent.com/66255821/164995757-cc34483c-dec3-42c8-8c74-a88bf8ed3dfd.png">

### Figure 8A: Best Bound Model in green and dark blue aligned with Best Unbound Model in cyan and HPEPDOCK model in purple from PyMol
<img width="229" alt="image" src="https://user-images.githubusercontent.com/66255821/164995775-8ca6544d-200a-4f81-92ac-4c1bbd28aae2.png">

### Figure 8B: Dermorphin conformations for all 10 refined models from PyMol
<img width="217" alt="image" src="https://user-images.githubusercontent.com/66255821/164995793-761e99ce-1b64-413f-8bad-6f91e6f2a8a7.png">

## REFERENCES
Allouche, S., Noble, F., & Marie, N. (2014). Opioid receptor desensitization: mechanisms and its link to tolerance. Frontiers in pharmacology, 5, 280.

Apweiler, R., Bairoch, A., Wu, C. H., Barker, W. C., Boeckmann, B., Ferro, S., ... & Yeh, L. S. L. (2004). UniProt: the universal protein knowledgebase. Nucleic acids research, 32(suppl_1), D115-D119.

Badaczewska-Dawid, A. E., Kmiecik, S., & Koliński, M. (2021). Docking of peptides to GPCRs using a combination of CABS-dock with FlexPepDock refinement. Briefings in bioinformatics, 22(3), bbaa109.

Bender, B. J., Vortmeier, G., Ernicke, S., Bosse, M., Kaiser, A., Els-Heindl, S., ... & Huster, D. (2019). Structural model of ghrelin bound to its G protein-coupled receptor. Structure, 27(3), 537-544.

Bhattacharya, A., Tejero, R., & Montelione, G. T. (2007). Evaluating protein structures determined by structural genomics consortia. Proteins: Structure, Function, and Bioinformatics, 66(4), 778-795.

Broccardo, M., Erspamer, V., Falconieri, G., Improta, G., Linari, G., Melchiorri, P., & Montecucchi, P. C. (1981). Pharmacological data on dermorphins, a new class of potent opioid peptides from amphibian skin. British journal of pharmacology, 73(3), 625-631.

Burley, S. K., Kurisu, G., Markley, J. L., Nakamura, H., Velankar, S., Berman, H. M., ... & Trewhella, J. (2017). PDB-Dev: a prototype system for depositing integrative/hybrid structural models. Structure, 25(9), 1317-1318.

Chu Sin Chung, P. C., and Kieffer, B. L. (2013). Delta opioid receptors in brain function and diseases. Pharmacol. Ther. 140, 112–120. doi: 10.1016/j.pharmthera.2013.06.003

Claff, T., Yu, J., Blais, V., Patel, N., Martin, C., Wu, L., ... & Stevens, R. C. (2019). Elucidating the active δ-opioid receptor crystal structure with peptide and small-molecule agonists. Science advances, 5(11), eaax9115.

Das, R., & Baker, D. (2008). Macromolecular modeling with rosetta. Annu. Rev. Biochem., 77, 363-382.
DeLano, W. L. (2002). PyMOL.

Dong, R., Pan, S., Peng, Z., Zhang, Y., & Yang, J. (2018). mTM-align: a server for fast protein structure database search and multiple protein structure alignment. Nucleic acids research, 46(W1), W380-W386.

Dong, R., Peng, Z., Zhang, Y., & Yang, J. (2018). mTM-align: an algorithm for fast and accurate multiple protein structure alignment. Bioinformatics, 34(10), 1719-1725.

D. Sehnal, S. Bittrich, M. Deshpande, R. Svobodová, K. Berka, V. Bazgier, S. Velankar, S.K. Burley, J. Koča, A.S. Rose (2021) Mol* Viewer: modern web app for 3D visualization and analysis of large biomolecular structures. Nucleic Acids Research. doi: 10.1093/nar/gkab314

Fenalti, G., Giguere, P. M., Katritch, V., Huang, X. P., Thompson, A. A., Cherezov, V., ... & Stevens, R. C. (2014). Molecular control of δ-opioid receptor signalling. Nature, 506(7487), 191-196.

Fenalti, G., Zatsepin, N. A., Betti, C., Giguere, P., Han, G. W., Ishchenko, A., ... & Cherezov, V. (2015). Structural basis for bifunctional peptide recognition at human δ-opioid receptor. Nature structural & molecular biology, 22(3), 265-268.

Gavériaux-Ruff, C., and Kieffer, B. L. (2011). Delta opioid receptor analgesia: recent contributions from pharmacology and molecular approaches. Behav. Pharmacol. 22, 405–414. doi: 10.1097/fbp.0b013e32834a1f2c

Goldenberg, D. L. (2010b). The interface of pain and mood disturbances in the rheumatic diseases. Semin. Arthritis Rheum. 40, 15–31. doi: 10.1016/j.semarthrit.2008.11.005

Greife, A., Felekyan, S., Ma, Q., Gertzen, C. G., Spomer, L., Dimura, M., ... & Seidel, C. A. (2016). Structural assemblies of the di-and oligomeric G-protein coupled receptor TGR5 in live cells: an MFIS-FRET and integrative modelling study. Scientific reports, 6(1), 1-16.

H.M. Berman, J. Westbrook, Z. Feng, G. Gilliland, T.N. Bhat, H. Weissig, I.N. Shindyalov, P.E. Bourne.

(2000) The Protein Data Bank Nucleic Acids Research, 28: 235-242.

H.M. Berman, K. Henrick, H. Nakamura (2003) Announcing the worldwide Protein Data Bank Nature Structural Biology 10 (12): 980. www.wwpdb.org

Jumper, J., Evans, R., Pritzel, A., Green, T., Figurnov, M., Ronneberger, O., ... & Hassabis, D. (2021). Highly accurate protein structure prediction with AlphaFold. Nature, 596(7873), 583-589. https://doi.org/10.1038/s41586-021-03819-2

Kastin, A. (Ed.). (2013). Handbook of biologically active peptides. Academic press.

Kurcinski, M., Badaczewska‐Dawid, A., Kolinski, M., Kolinski, A., & Kmiecik, S. (2020). Flexible docking of peptides to proteins using CABS‐dock. Protein Science, 29(1), 211-222.

Lazarus, L. H., Wilson, W. E., Guglietta, A., & De Castiglione, R. (1990). Dermorphin interaction with rat brain opioid receptors: involvement of hydrophobic sites in the binding domain. Molecular pharmacology, 37(6), 886-892.

Leelananda, S. P., & Lindert, S. (2017). Iterative molecular dynamics–rosetta membrane protein structure refinement guided by cryo-em densities. Journal of chemical theory and computation, 13(10), 5131-5145.

London, N., Raveh, B., Cohen, E., Fathi, G., & Schueler-Furman, O. (2011). Rosetta FlexPepDock web server—high resolution modeling of peptide–protein interactions. Nucleic acids research, 39(suppl_2), W249-W253.

Patra, M. C., Kumar, K., Pasha, S., & Chopra, M. (2012). Comparative modeling of human kappa opioid receptor and docking analysis with the peptide YFa. Journal of Molecular Graphics and Modelling, 33, 44-51.

Pettersen, E. F., Goddard, T. D., Huang, C. C., Couch, G. S., Greenblatt, D. M., Meng, E. C., & Ferrin, T. E. (2004). UCSF Chimera—a visualization system for exploratory research and analysis. Journal of computational chemistry, 25(13), 1605-1612.

Quirion, B., Bergeron, F., Blais, V., & Gendron, L. (2020). The delta-opioid receptor; a target for the treatment of pain. Frontiers in Molecular Neuroscience, 13, 52.

Raveh, B., London, N., & Schueler‐Furman, O. (2010). Sub‐angstrom modeling of complexes between flexible peptides and globular proteins. Proteins: Structure, Function, and Bioinformatics, 78(9), 2029-2040.

Raveh, B., London, N., Zimmerman, L., & Schueler-Furman, O. (2011). Rosetta FlexPepDock ab-initio: simultaneous folding, docking and refinement of peptides onto their receptors. PloS one, 6(4), e18934.

Rohl, C. A., Strauss, C. E., Misura, K. M., & Baker, D. (2004). Protein structure prediction using Rosetta. In Methods in enzymology (Vol. 383, pp. 66-93). Academic Press.

Sievers, F., & Higgins, D. G. (2014). Clustal omega. Current protocols in bioinformatics, 48(1), 3-13.

Sievers, F., & Higgins, D. G. (2014). Clustal Omega, accurate alignment of very large numbers of sequences. In Multiple sequence alignment methods (pp. 105-116). Humana Press, Totowa, NJ.

Ślusarz, M. J. (2011). Molecular modeling study of the opioid receptor interactions with series of cyclic deltorphin analogues. Journal of Peptide Science, 17(8), 554-564.

Song, Y., DiMaio, F., Wang, R. Y. R., Kim, D., Miles, C., Brunette, T. J., ... & Baker, D. (2013). High-resolution comparative modeling with RosettaCM. Structure, 21(10), 1735-1742.

Tsirigos, K. D., Peters, C., Shu, N., Käll, L., & Elofsson, A. (2015). The TOPCONS web server for consensus prediction of membrane protein topology and signal peptides. Nucleic acids research, 43(W1), W401-W407.

Vats, I. D., Dolt, K. S., Kumar, K., Karar, J., Nath, M., Mohan, A., ... & Pasha, S. (2008). YFa, a chimeric opioid peptide, induces kappa‐specific antinociception with no tolerance development during 6 days of chronic treatment. Journal of neuroscience research, 86(7), 1599-1607.

Viklund, H., & Elofsson, A. (2008). OCTOPUS: improving topology prediction by two-track ANN-based preference scores and an extended topological grammar. Bioinformatics, 24(15), 1662-1668.

Zemla, A., Geisbrecht, B., Smith, J., Lam, M., Kirkpatrick, B., Wagner, M., ... & Zhou, C. E. (2007). STRALCP—structure alignment-based clustering of proteins. Nucleic acids research, 35(22), e150-e150.

Zhou, P., Jin, B., Li, H., & Huang, S. Y. (2018). HPEPDOCK: a web server for blind peptide–protein docking based on a hierarchical algorithm. Nucleic acids research, 46(W1), W443-W450.

Zhou, P., Li, B., Yan, Y., Jin, B., Wang, L., & Huang, S. Y. (2018). Hierarchical flexible peptide docking by conformer generation and ensemble docking of peptides. Journal of Chemical Information and Modeling, 58(6), 1292-1302.
