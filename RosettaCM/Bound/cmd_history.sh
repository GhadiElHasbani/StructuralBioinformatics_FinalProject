cd ~/StructuralBioinformatics_FinalProject/RosettaCM
cd Bound

#From Refine1/ or Refine2/ dir
cd Refine1
    #OR
cd Refine2

    #From Refine{X}/Prepacking
    cd Prepacking ~/Desktop/rosetta/main/source/build/src/release/macos/10.13/64/x86/clang/9.0/static/FlexPepDocking.static.macosclangrelease @prepack_flags
    
cd ..
~/Desktop/rosetta/main/source/build/src/release/macos/10.13/64/x86/clang/9.0/static/FlexPepDocking.static.macosclangrelease @refine_flags > refine.log

# From Templates/ dir
cd Templates
ls *.pdb | awk -F. '{print $1}' > list_of_pdbs.txt
python ~/Desktop/rosetta/main/tools/protein_tools/scripts/clean_pdb.py S_0001.pdb A
python ~/Desktop/rosetta/main/tools/protein_tools/scripts/clean_pdb.py S_0002.pdb A
python ~/Desktop/rosetta/main/tools/protein_tools/scripts/clean_pdb.py S_0003.pdb A
python ~/Desktop/rosetta/main/tools/protein_tools/scripts/clean_pdb.py AF-P41143-F1-model_v2.pdb A

# From Constraints/ dir
# Octopus was down, used TopCons2 (which proved to be more accurate --> 7 vs 5 TMHs)
cd ../Constraints
~/Desktop/rosetta/main/source/src/apps/public/membrane_abinitio/octopus2span.pl dorh.octopus > dorh.span

# From main dir
cd ..
python aln2grishin.py --file Alignments/dorh_alignment.txt

# From threaded_pdbs/ dir
cd threaded_pdbs
~/Desktop/rosetta/main/source/bin/partial_thread.static.macosclangrelease -in:file:fasta ../dorh_full.fasta -in:file:alignment ../Alignments/dorh_S_0001_A.grishin -in:file:template_pdb ../Templates/S_0001_A.pdb
~/Desktop/rosetta/main/source/bin/partial_thread.static.macosclangrelease -in:file:fasta ../dorh_full.fasta -in:file:alignment ../Alignments/dorh_S_0002_A.grishin -in:file:template_pdb ../Templates/S_0002_A.pdb
~/Desktop/rosetta/main/source/bin/partial_thread.static.macosclangrelease -in:file:fasta ../dorh_full.fasta -in:file:alignment ../Alignments/dorh_S_0003_A.grishin -in:file:template_pdb ../Templates/S_0003_A.pdb
~/Desktop/rosetta/main/source/bin/partial_thread.static.macosclangrelease -in:file:fasta ../dorh_full.fasta -in:file:alignment ../Alignments/dorh_docked_renumbered.grishin -in:file:template_pdb ../Templates/docked_renumbered.pdb
~/Desktop/rosetta/main/source/bin/partial_thread.static.macosclangrelease -in:file:fasta ../dorh_full.fasta -in:file:alignment ../Alignments/dorh_AF-P41143-F1-model_v2_A.grishin -in:file:template_pdb ../Templates/AF-P41143-F1-model_v2_A.pdb

# From inputs/ dir
cd ../inputs
~/Desktop/rosetta/main/source/bin/rosetta_scripts.static.macosclangrelease @ rosetta_cm.options > rosetta_cm.log &
history

# From Results_Analysis/Clustering
cd ../Results_Analysis/Clustering
tar -cvzf models.tar.gz *.pdb
