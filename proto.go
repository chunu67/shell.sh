// Command eval is a chromedp example demonstrating how to evaluate javascript
// and retrieve the result.
package main

import (
	"context"
	"log"
	"bufio"
	"os"
	"github.com/chromedp/chromedp"
	"flag"
)

func main() {
	var  inpJS  string
	flag.StringVar(&inpJS, "J" ,"" ,"The Js to run on each page")
	sc := bufio.NewScanner(os.Stdin)
	for sc.Scan() {
		u := sc.Text()
		// create context
		ctx, cancel := chromedp.NewContext(context.Background())
		defer cancel()
		// run task list
		var res string
		err := chromedp.Run(ctx,
			chromedp.Navigate(u),
			chromedp.Evaluate(`window.test`, &res),
		)
		if err != nil {
			log.Printf("error %s on  %s",err,u)
			continue
		}
		log.Printf("%s : %v",u , res)
	}
}

