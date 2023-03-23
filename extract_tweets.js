async function extractTweets(amount) {
    let tweetCount = 0;
    let allContents = "";
    while (tweetCount < amount) {
        // page is open with ten tweets then we need to scroll
        let tweetsOnPage = document.querySelectorAll('div[data-testid="tweetText"]');
        for (tweet of tweetsOnPage) {
            console.log(`--> tweet number = ${tweetCount}`);
            let allSpansInTweet = tweet.querySelectorAll("span");
            for (span of allSpansInTweet) {
                let cleanedText = span.innerText.trim().toLowerCase();
                allContents = allContents.concat(" ", cleanedText);
            }
            // finished a tweet
            tweetCount++;
        }
        console.log(`Scrolling down`);
        window.scrollBy(0,4000);
        await new Promise(r => setTimeout(r, 2000));
    }
    return allContents;
}
