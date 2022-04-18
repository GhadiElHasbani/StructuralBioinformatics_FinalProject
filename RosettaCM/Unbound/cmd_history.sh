cd ~/Desktop/RosettaCM\ delta\ opioid\ trial/

# From Templates/ dir
cd Templates
ls *.pdb | awk -F. '{print $1}' > list_of_pdbs.txt
python ~/Desktop/rosetta/main/tools/protein_tools/scripts/clean_pdb.py 4n6h.pdb
python ~/Desktop/rosetta/main/tools/protein_tools/scripts/clean_pdb.py 4n6h.pdb A
python ~/Desktop/rosetta/main/tools/protein_tools/scripts/clean_pdb.py 4rwa.pdb A
python ~/Desktop/rosetta/main/tools/protein_tools/scripts/clean_pdb.py 6pt2.pdb A
python ~/Desktop/rosetta/main/tools/protein_tools/scripts/clean_pdb.py 4rwd.pdb A
python ~/Desktop/rosetta/main/tools/protein_tools/scripts/clean_pdb.py 6pt3.pdb A
python ~/Desktop/rosetta/main/tools/protein_tools/scripts/clean_pdb.py AF-P41143-F1-model_v2.pdb A
# Octopus was down, used TopCons2 (which proved to be more accurate --> 7 vs 5 TMHs)
~/Desktop/rosetta/main/source/src/apps/public/membrane_abinitio/octopus2span.pl ../dorh.octopus > dorh.span

# From main dir
python aln2grishin.py --file Alignments/dorh_alignment_all.txt

# From threaded_pdbs/ dir
../dorh_full.fasta -in:file:alignment dorh_4n6h_A.grishin -in:file:template_pdb ../Templates/4n6h_A.pdb
~/Desktop/rosetta/main/source/bin/partial_thread.static.macosclangrelease -in:file:fasta ../dorh_full.fasta -in:file:alignment ../Alignments/dorh_4rwa_A.grishin -in:file:template_pdb ../Templates/4rwa_A.pdb
~/Desktop/rosetta/main/source/bin/partial_thread.static.macosclangrelease -in:file:fasta ../dorh_full.fasta -in:file:alignment ../Alignments/dorh_4rwd_A.grishin -in:file:template_pdb ../Templates/4rwd_A.pdb
~/Desktop/rosetta/main/source/bin/partial_thread.static.macosclangrelease -in:file:fasta ../dorh_full.fasta -in:file:alignment ../Alignments/dorh_6pt2_A.grishin -in:file:template_pdb ../Templates/6pt2_A.pdb
~/Desktop/rosetta/main/source/bin/partial_thread.static.macosclangrelease -in:file:fasta ../dorh_full.fasta -in:file:alignment ../Alignments/dorh_6pt3_A.grishin -in:file:template_pdb ../Templates/6pt3_A.pdb
~/Desktop/rosetta/main/source/bin/partial_thread.static.macosclangrelease -in:file:fasta ../dorh_full.fasta -in:file:alignment ../Alignments/dorh_AF-P41143-F1-model_v2_A.grishin -in:file:template_pdb ../Templates/AF-P41143-F1-model_v2_A.pdb

# From inputs/ dir
~/Desktop/rosetta/main/source/bin/rosetta_scripts.static.macosclangrelease @ rosetta_cm.options > rosetta_cm.log &
history
