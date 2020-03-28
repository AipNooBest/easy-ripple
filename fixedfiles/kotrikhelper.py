import math
from objects import glob

def secondsToFormatted(length):
	return "{math.floor(length / 60)}:{str(length % 60)}"
	
def setUserLastOsuVer(userID: int, osuVer: str):
	"""
	Set userID's osu ver
	Thanks to osu!Kurikku's pep.py
	Commit ID: 64f4109b6507ee218fdaa7c3e45433df0a02a8e5
	
	:param userID int: user id
	:param osuVer str: osu ver
	:return:
	"""
	glob.db.execute("UPDATE users SET osuver = %s WHERE id = %s LIMIT 1", [osuVer, userID])