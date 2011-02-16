import datetime
import PyRSS2Gen
from optparse import OptionParser

parser = OptionParser()
parser.add_option("-f", "--folder", dest="foldername",
                  help="name of new folder (relative) to /var/ww/Android",)
(options, args) = parser.parse_args()
name = str(options.foldername)

rss = PyRSS2Gen.RSS2(
    title = "Android for Overo Builder feed",
    link = "http://cumulus.gumstix.org/Android/",
    description = "Feed summarizing most recent Android builds"
                  "for Gumstix Overo COMs.",

    lastBuildDate = datetime.datetime.utcnow(),

    items = [
       PyRSS2Gen.RSSItem(
         title = "Android Build " + name,
         link = "http://cumulus.gumstix.org/Android/" + name,
         description = "The most recent Android build for Overo",
         guid = PyRSS2Gen.Guid("http://cumulus.gumstix.org/Android/"+ name),
         pubDate = datetime.datetime.utcnow(),)
    ])

#rss.write_xml(open("feed.xml", "w"))
rss.write_xml(open("/var/ww/Android/feed.xml", "w"))

