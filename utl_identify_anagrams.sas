SAS/Python Identify anagrams;

  INPUT  (Find anagrams for domitort)

        "dormitory"

        "dirtyroom", "mycollege", "myparties", "graduates"

   PROCESS

      PYTHON
      ======
         %utl_submit_py64('
         word = sorted("dormitory");
         alternatives = ["dirtyroom", "mycollege", "myparties", "graduates"];
         for alt in alternatives:;
         .   if word == sorted(alt):;
         .       print alt;
         ');

      SAS
      ===
       MAINLINE
       ========
        word="dormitory";
        call symputx("word",word);

        do ang= "dirtyroom", "mycollege", "myparties", "graduates";
          call symputx('ang',ang);

        DOSUBL
        ======
               array ltrs[&len] $1;

               word="&word";
               call pokelong(word,addrlong(ltrs1),&len);
               call sortc(of ltrs[*]);
               word = cat(of ltrs[*]);

               ang="&ang";
               call pokelong(ang,addrlong(ltrs1),&len);
               call sortc(of ltrs[*]);
               ang = cat(of ltrs[*]);

               if word=ang then call symputx("flg","1");
               else call symputx("flg","0");
           ');

        MAINLINE
        ========
            if symget('flg')='1' then putlog "anagram " word= ang=;

        OUTPUT
        ======
            anagram    WORD=dormitory    ANAGRAM=dirtyroom


see
https://goo.gl/sBSGGf
https://stackoverflow.com/questions/8286554/using-python-find-anagrams-for-a-list-of-words

see Felix Loetherprofile
https://stackoverflow.com/users/836611/felix-loether

see
https://goo.gl/JCOrym
http://stackoverflow.com/questions/43812674/sort-letters-in-string-alphabetically-sas

user667489 profile
http://stackoverflow.com/users/667489/user667489

*                _               _       _
 _ __ ___   __ _| | _____     __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \   / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/  | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|   \__,_|\__,_|\__\__,_|

;

  data is in the scripts

  word="dormitory";
  do ang= "dirtyroom", "mycollege", "myparties", "graduates";

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __  ___
/ __|/ _ \| | | | | __| |/ _ \| '_ \/ __|
\__ \ (_) | | |_| | |_| | (_) | | | \__ \
|___/\___/|_|\__,_|\__|_|\___/|_| |_|___/

 ___  __ _ ___
/ __|/ _` / __|
\__ \ (_| \__ \
|___/\__,_|___/

;

%symdel word ang len / nowarn;

data want;

  word="dormitory";
  call symputx("word",word);

  do ang= "dirtyroom", "mycollege", "myparties", "graduates";
    call symputx('ang',ang);

    rc=dosubl('
       %let len=%length(&word);
       data _null_;
         array ltrs[&len] $1;

         word="&word";
         call pokelong(word,addrlong(ltrs1),&len);
         call sortc(of ltrs[*]);
         word = cat(of ltrs[*]);

         ang="&ang";
         call pokelong(ang,addrlong(ltrs1),&len);
         call sortc(of ltrs[*]);
         ang = cat(of ltrs[*]);

         if word=ang then call symputx("flg","1");
         else call symputx("flg","0");

       run;quit;
     ');

      if symget('flg')='1' then putlog "anagram " word= ang=;
  end;

run;quit;

anagram    WORD=dormitory    ANG=dirtyroom

*            _   _
 _ __  _   _| |_| |__   ___  _ __
| '_ \| | | | __| '_ \ / _ \| '_ \
| |_) | |_| | |_| | | | (_) | | | |
| .__/ \__, |\__|_| |_|\___/|_| |_|
|_|    |___/
;

%utl_submit_py64('
word = sorted("dormitory");
alternatives = ["dirtyroom", "mycollege", "myparties", "graduates"];
for alt in alternatives:;
.   if word == sorted(alt):;
.       print alt;
');

dirtyroom

