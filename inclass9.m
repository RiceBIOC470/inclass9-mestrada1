% Inclass assignment 9

% The accession number for human NOTCH1 mRNA is AF308602
% 1. Read the information from this entry into matlab

accession = 'AF308602';
gb_data = getgenbank(accession);
notch1mRNA = gb_data.Sequence(1:500);

% 2. Write code that runs a blast query on the first 500 base pairs of this
% gene against the refseq_rna database

[request_ID, requestTime] = blastncbi(notch1mRNA, 'blastn', 'Database', 'refseq_rna');
blast_data = getblast(request_ID, 'WaitTime', requestTime)


% 3. Find the three highest scoring hits from other species and identify
% the length of the alignment and fraction of matches/mismatches. 

% 1st Highest Scoring Hit-Other than Homo sapiens (Species: Pan troglodytes)

blast_data.Hits(2)
ans = 

  struct with fields:

      Name: 'gi|1034189095|ref|XM_009457722.2| PREDICTED: Pan troglodytes notch 1 (NOTCH1), transcript variant X4, mRNA'
    Length: 9309
      HSPs: [1×4 struct]
      
score1 = blast_data.Hits(2).HSPs.Score;
score1
ans =

   888

% Only care about first score (888)

panalignlength = blast_data.Hits(2).HSPs.Alignment; % Length = 500 base pairs
panalignfraction = blast_data.Hits(2).HSPs.Identities;
panalignfraction

panalignfraction = 

  struct with fields:

       Match: 497
    Possible: 500
     Percent: 99


% 2nd Highest Scoring Hit (Species: Rhinopithecus bieti) 

blast_data.Hits(6)

ans = 

  struct with fields:

      Name: 'gi|1059184574|ref|XM_017892998.1| PREDICTED: Rhinopithecus bieti notch 1 (NOTCH1), mRNA'
    Length: 7683
      HSPs: [1×2 struct]
      
score2 = blast_data.Hits(6).HSPs.Score;     
score2

score2 =

   848 %Alignment Score
   
rhinoalignlength = blast_data.Hits(6).HSPs.Alignment; % Length = 500 base pairs
rhinoalignfraction = blast_data.Hits(6).HSPs.Identities;
rhinoalignfraction

rhinoalignfraction = 

  struct with fields:

       Match: 488
    Possible: 500
     Percent: 98
     
% 3rd Highest Scoring Hit (Species: Cerocebus atys) 

blast_data.Hits(7)

ans = 

  struct with fields:

      Name: 'gi|795540728|ref|XM_012048960.1| PREDICTED: Cercocebus atys notch 1 (NOTCH1), mRNA'
    Length: 8166
      HSPs: [1×4 struct]
      
score3 = blast_data.Hits(7).HSPs.Score;
score3

score3 =

   839 %Alignment Score
   
cercoalignlength = blast_data.Hits(7).HSPs.Alignment; % Length = 500 basepairs
cercoalignfraction = blast_data.Hits(7).HSPs.Identities; 
cercoalignfraction = 

  struct with fields:

       Match: 486
    Possible: 500
     Percent: 97
     
% 4. Run the same query against the database est_human. Comment on the
% sequences that you find. 

[request_ID, requestTime] = blastncbi(notch1mRNA, 'blastn', 'Database', 'est_human');
blast_data2 = getblast(request_ID, 'WaitTime', requestTime)
blast_data2.Hits(1)

% This BLAST query yields hits with much smaller alignments and alignment
% scores relative to the RNA database used in the first query (See example 
% below). The results yield alignments with cDNA clones for NOTCH1 mRNA in
% Homo sapiens initially, but also yield random sequences that have
% alignment with NOTCH1, even if those alignments are very small in length.
% (See alignment length example below)

blast_data2.Hits(1).HSPs

ans = 

  struct with fields:

             Score: 499
            Expect: 1.0000e-138
        Identities: [1×1 struct]
              Gaps: [1×1 struct]
            Strand: 'Plus/Plus'
         Alignment: [3×279 char]
      QueryIndices: [222 500]
    SubjectIndices: [1 279]
    
alignment4 = blast_data2.Hits(4).HSPs.Alignment; % Length = only 30 base pairs