from os import listdir, system
import collections

# check % of exercises solved for each chapter of SICP
EXERCISES_PER_CHAPTER = {1 : 46, 2 : 97, 3 : 82, 4 : 79, 5 : 52}
progress = collections.defaultdict(int)

system('./cleanup.sh')
for chapter in EXERCISES_PER_CHAPTER:
    dirname = "ch" + str(chapter)
    for f in listdir(dirname):
        if f[-4:] == ".scm":
            progress[chapter] += 1

for chapter in EXERCISES_PER_CHAPTER:
    print( "Chapter {}: {:2.2%} ({} of {})".format( chapter, progress[chapter]
                                                  /EXERCISES_PER_CHAPTER[chapter],
                                                  progress[chapter],
                                                  EXERCISES_PER_CHAPTER[chapter]))

k=sum(progress.values())
n=sum(EXERCISES_PER_CHAPTER.values())
print("TOTAL:     {:2.2%} ({} of {})".format(k/n, k, n))
