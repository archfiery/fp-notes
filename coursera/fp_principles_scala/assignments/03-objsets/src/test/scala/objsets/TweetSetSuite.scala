package objsets

import java.util.NoSuchElementException

import org.scalatest.FunSuite
import org.junit.runner.RunWith
import org.scalatest.junit.JUnitRunner

@RunWith(classOf[JUnitRunner])
class TweetSetSuite extends FunSuite {

  trait TestSets {
    val set1 = new Empty
    val set2 = set1.incl(new Tweet("a", "a body", 20))
    val set3 = set2.incl(new Tweet("b", "b body", 20))
    val c = new Tweet("c", "c body", 7)
    val d = new Tweet("d", "d body", 9)
    val set4c = set3.incl(c)
    val set4d = set3.incl(d)
    val set5 = set4c.incl(d)
  }

  def asSet(tweets: TweetSet): Set[Tweet] = {
    var res = Set[Tweet]()
    tweets.foreach(res += _)
    res
  }

  def size(set: TweetSet): Int = asSet(set).size

  test("filter: on empty set") {
    new TestSets {
      assert(size(set1.filter(tw => tw.user == "a")) === 0)
    }
  }

  test("filter: a on set5") {
    new TestSets {
      assert(size(set5.filter(tw => tw.user == "a")) === 1)
    }
  }

  test("filter: 20 on set5") {
    new TestSets {
      assert(size(set5.filter(tw => tw.retweets == 20)) === 2)
    }
  }

  test("union: set4c and set4d") {
    new TestSets {
      assert(size(set4c.union(set4d)) === 4)
    }
  }

  test("union: with empty set (1)") {
    new TestSets {
      assert(size(set5.union(set1)) === 4)
    }
  }

  test("union: with empty set (2)") {
    new TestSets {
      assert(size(set1.union(set5)) === 4)
    }
  }

  test("descending: set5") {
    new TestSets {
      val trends = set5.descendingByRetweet
      assert(!trends.isEmpty)
      assert(trends.head.user == "a" || trends.head.user == "b")
    }
  }

  test("empty tweet list") {
    new TestSets {
      val xt = set1.descendingByRetweet
      assert(xt.isEmpty)
      assert(xt == Nil)
    }
  }

  test("most tweeted") {
    new TestSets {
      val x = set2.mostRetweeted
      assert(x.retweets == 20)
      val setBeatles = set3.incl(new Tweet("x", "Hey Jude", 1968))
      assert(setBeatles.mostRetweeted.retweets == 1968)
      assert(set3.mostRetweeted.retweets == 20)
      assert(set5.mostRetweeted.retweets == 20)
    }
  }

  test("desc tweets") {
    new TestSets {
      val setBeatles = set5.incl(new Tweet("d", "Dr. Robert", 1966))
      assert(setBeatles.mostRetweeted.retweets == 1966)
    }
  }

  test("tweets with 321 retweets") {
    new TestSets {
      val ts = TweetReader.allTweets.filter(x => x.retweets == 321)
      assert(!ts.empty)
    }
  }

  test("google & apple") {
    def count(ts: TweetSet, acc: Int): Int = {
      if (ts.empty) 0
      else 1 + count(ts.remove(ts.mostRetweeted), acc)
    }
    new TestSets {
      //GoogleVsApple.trending foreach println
      println("total tweets: " + count(GoogleVsApple.appleTweets union GoogleVsApple.googleTweets, 0))
      println("total tweets: " + count(GoogleVsApple.appleTweets.union(GoogleVsApple.googleTweets), 0))
      println("apple tweets: " + count(GoogleVsApple.appleTweets, 0))
      println("apple exclusive tweets: " + count(GoogleVsApple.appleExclusive, 0))
      println("google tweets: " + count(GoogleVsApple.googleTweets, 0))
      println("google exclusive tweets: " + count(GoogleVsApple.googleExclusive, 0))
      println("intersection: " + count(GoogleVsApple.intersect, 0))
    }
  }

}
