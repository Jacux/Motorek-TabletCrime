       
        $( document ).ready(function() {




        });
                    let page = 'home';
            
        function Change(web) 
        {
            if(web == page) {return;}
            $(`#${web}`).show();
            $(`#${page}`).hide();
            page = web;
        }
        function invite() 
        {

            var id = document.getElementById('tentacles').value
      
            $.post(`https://Motorek-TabletCrime/invite`, JSON.stringify({
id: id
                    }));

        
                    document.getElementById('tentacles').value = ""
        }

        function upgrade(lvl) 
        {


      
            $.post(`https://Motorek-TabletCrime/upgrade`, JSON.stringify({
lvl: lvl
                    }));

        
   
        }
        function przelej(coin) 
        {


      
            $.post(`https://Motorek-TabletCrime/przelej`, JSON.stringify({
coin: coin
                    }));

        
   
        }
        function sprzedaj(coin) 
        {


      
            $.post(`https://Motorek-TabletCrime/sprzedaj`, JSON.stringify({
coin: coin
                    }));

        
   
        }

        function buyc(coin) 
        {


      
            $.post(`https://Motorek-TabletCrime/buyc`, JSON.stringify({
coin: coin
                    }));

        
   
        }
        function medyk() 
        {


      
            $.post(`https://Motorek-TabletCrime/medyk`, JSON.stringify({

                    }));

        
   
        }

        function sklep(item, count, cena) 
        {
            console.log(item)
            console.log(count)
            console.log(cena)
            $.post(`https://Motorek-TabletCrime/sklep`, JSON.stringify({
                item: item,
                count: count,
                price: cena
                    }));

        }
        
        function Zapisz(id) {
        var a = document.getElementsByName(id)[0].value;
        $.post(`https://Motorek-TabletCrime/save`, JSON.stringify({
            grade: a,
            isn: id
                                }));
        }
        function display(bool) {
            console.log(bool)
            if (bool) {
                $("#container").show();
                
            } else {
                
                $("#container").hide();
                
            }
        }

        window.addEventListener('message', function(event) {
            console.log(event.data.type)
            var item = event.data;
            if (item.type == "clear") {
                $(".ludzik").remove();
            }

            if (item.type === "update") {
                
                console.log("test")
                var exp = item.exp;
                console.log(exp)
                var cenabtc = item.cenabtc
                var cenaeth = item.cenaeth
                var cenadoge = item.cenadoge
                var btc = item.btc
                var eth =item.eth
                var doge = item.doge
                var srodki = item.srodki
                var wallet = item.wallet
                var up = item.upgrade
                document.getElementById('grupa').innerHTML = item.name;
                document.getElementById('nrportfelak').innerHTML = wallet;
                document.getElementById('nrportfelak2').innerHTML = wallet;
                document.getElementById('btcstan').innerHTML = btc;
                document.getElementById('ethstan').innerHTML = eth;
                document.getElementById('dogestan').innerHTML = doge;
                document.getElementById('btc2').innerHTML = btc;
                document.getElementById('eth2').innerHTML = eth;
                document.getElementById('doge2').innerHTML = doge;
                document.getElementById('btc1').innerHTML = btc;
                document.getElementById('eth1').innerHTML = eth;
                document.getElementById('doge1').innerHTML = doge;
                document.getElementById('cenabtc').innerHTML = cenabtc;
                document.getElementById('cenaeth').innerHTML = cenaeth;
                document.getElementById('cenadoge').innerHTML = cenadoge;
                document.getElementById('cenabtc1').innerHTML = cenabtc;
                document.getElementById('cenaeth1').innerHTML = cenaeth;
                document.getElementById('cenadoge1').innerHTML = cenadoge;
console.log(up)
if (item.medyk == 1) {
    $("#medyk").hide();
    
}
if (up == 1) {
    $("#levell1").hide();
}
if (up == 2) {
    $("#levell1").hide();
    $("#levell2").hide();
}
if (up == 3 ){


    $("#levell1").hide();
    $("#levell2").hide();
    $("#levell3").hide();
}
            }
            if (item.type == "misiaczki") {
                console.log("works")
                var car = `                         <tr class="ludzik"><td><div id="status" class=`+item.status+`></div>
                </td><td>`+item.name+`</td>
                <td style="text-align: center">`+item.id+`</td>
                <td style="text-align: center">`+item.grade+`</td>
                <td style="text-align: center">

                    <select class="choose" name=`+item.id+` id="cars">
                        <option value="wybierz">Wybierz opcję</option>
                        <option value="4">Szef</option>
                        <option value="3">Zastępca</option>
                        <option value="2">Kapitan</option>
                        <option value="1">Członek</option>
                        <option value="0">Rekrut</option>
                        <option value="z">Zwolnij</option>
                    </select>
                    <button onclick="Zapisz(`+item.id+`);" id="zapisz" class="zapisz">Zapisz</td></tr>`;
		
	  $("#testowa").append(car);
      document.getElementById('count').innerHTML = item.liczbaa+"/"+item.max;
            }
            if (item.type == "sklep") {
                var click = "sklep('"+item.item+"','"+item.count+"','"+item.price+"')"

                var sklyp = `                            <div class="embed3sklep">
                <h2>`+item.title+`</h2>
                <h3>`+item.desc+`</h3>
                <br>
                <h3>Cena: <span class="ethereum">`+item.price+`</span></h3>
                <button onclick=`+click+` class="buy">Zakup!</button>
            </div>`;
		
	  $("#shops").append(sklyp);
      document.getElementById('lvl1').innerHTML = item.lvl1;
      document.getElementById('lvl2').innerHTML = item.lvl2;
      document.getElementById('lvl3').innerHTML = item.lvl3;
            }

            if (item.type === "ui") {
               
                if (item.status == true) {
                    display(true)
                    $("#levell1").show();
                    $("#levell2").show();
                    $("#levell3").show();
                } else {
                    $(".embed3sklep").remove();
                    
                    display(false)
                    
                    
                }
                
            }

        })

        document.onkeyup = function (data) {
            if (data.which == 27) {
                $.post('https://Motorek-TabletCrime/exit', JSON.stringify({}));
                return
            }
        }

