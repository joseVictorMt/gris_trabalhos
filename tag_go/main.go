package main

import (
	"fmt"
	"html/template"
	"log"
	"net"
	"net/http"
	"sync"
    "time"
    "strconv"
)

func scan(host string, port int, wg *sync.WaitGroup, data chan string) error {
    defer wg.Done()

    address := fmt.Sprintf("%s:%d", host, port)
    conn, err := net.Dial("tcp", address)

    if err != nil {
        data <- fmt.Sprintf("%s\tPorta %d: fechada", time.Now().Format("01/02/2006 15:04:05"), port)
        return err
    }

    conn.Close()
    data <- fmt.Sprintf("%s\tPorta %d: aberta", time.Now().Format("01/02/2006 15:04:05"), port)
    return nil
}

func getDataScan(host string, from int, to int) []string {
    var wg sync.WaitGroup

    data, data_list := make(chan string), make([]string, 0)

    for port := from; port <= to; port++ {
        wg.Add(1)
        go scan(host, port, &wg, data)
        log_msg := <- data
        data_list = append(data_list, log_msg)
    }

    wg.Wait()

    return data_list
}

func index(w http.ResponseWriter, req *http.Request) {

    ip := req.FormValue("ip")
    from, err_1 := strconv.Atoi(req.FormValue("from"))
    to, err_2 := strconv.Atoi(req.FormValue("to"))
    if err_1 != nil {
        fmt.Println("O parâmetro da porta limite 'from' deve ser inteiro.")
    } else if err_2 != nil {
        fmt.Println("O parâmetro da porta limite 'to' deve ser inteiro.")
    }
    data_log := getDataScan(ip, from, to)

    for i := 0; i < len(data_log); i++ {
        fmt.Println(data_log[i])
    }

	tp1, _ := template.ParseFiles("index.html")
	data := map[string] string {
		"Title" :   "Primeira página em go XD",
        "IP"    :   ip,
        "From"  :   req.FormValue("from"),
        "To"    :   req.FormValue("to"),
	}
	w.WriteHeader(http.StatusOK)
	tp1.Execute(w, data)
}

func main() {
	http.HandleFunc("/", index)
	fmt.Println("Servidor rodando na porta 8080.")
	log.Fatal(http.ListenAndServe(":8080", nil))
    // http://localhost:8080/?ip=127.0.0.1&from=8070&to=8090
}
