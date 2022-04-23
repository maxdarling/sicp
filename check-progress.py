from os import listdir, system
#from collections import defaultdict
import collections

# check % of exercises solved for each chapter of SICP
EXERCISES_PER_CHAPTER = {1 : 46, 2 : 97, 3 : 82, 4 : 79, 5 : 52}
progress = collections.defaultdict(int)

system('./cleanup.sh')
for f in listdir():
    if f[-4:] == ".scm":
        chapter = int(f[0])
        progress[chapter] += 1

for chapter in EXERCISES_PER_CHAPTER.keys():
    print( "Chapter {}: {:2.2%}".format(chapter, progress[chapter] /
        EXERCISES_PER_CHAPTER[chapter]))
