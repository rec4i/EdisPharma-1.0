

$(document).ready(function () {
   
    var countDownDate = new Date("2021/04/28 08:00:53").getTime(); //geri sayılacak ileri zamanki bir tarihi milisaniye cinsinden elde ediyoruz

    $.ajax({
        url: 'Sınav-Detay.aspx/Sınav_Tarihi',
        dataType: 'json',
        type: 'POST',
        data: "{'parametre': ''}",
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
      
            var countDownDate_temp =new Date(data.d)

            countDownDate = countDownDate_temp
            

        },
        error: function () {

            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

        }
    });
    var dayText = "Gün";
    var hourText = "Saat";
    var minuteText = "Dakika";
    var secondText = "Saniye";
    if (countDownDate) { //tarih var ise
        var x = setInterval(function () { //sayacı belirli aralıklarla yenile
            var now = new Date().getTime(); //şimdiki zamanı al
            var distance = countDownDate - now; //geri sayılacak tarih ile şimdiki tarih arasındaki zaman farkını al
            if (distance < 0) { //zaman farkı yok ise belirtilen zamanı geçti
                clearInterval(x); //sayacı sil
                window.location.href = "/Sınav.aspx"
            } else { //zaman farkı var ise
                //aradaki zaman farkını gün,saat,dakika,saniye olarak böl
                var days = Math.floor(distance / (1000 * 60 * 60 * 24)),
                    hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)),
                    minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60)),
                    seconds = Math.floor((distance % (1000 * 60)) / 1000),
                    hours = (hours ? '<span >' + hours + ':</span>' : '00:'), //saat varsa saat degerini yaz
                    minutes = (minutes ? '<span>' + minutes + ':</span>'  : '00:'), //dakika varsa dakika degerini yaz
                    seconds = (seconds ? '<span>' + seconds + '</span>'  : '00'); //saniye varsa saniye degerini yaz
                document.getElementById("countdown_timer").innerHTML =  hours + minutes + seconds; //yazdır
            }
        }, 1000); //1 saniyede bir sayaç güncellenecek
    }

    var Soru_Listesi = $('ul[id=Soru_Listesi]')
    var Soru = $('span[id=Soru]')
    var Sık_1 = $('label[id=Sık_1]')
    var Sık_2 = $('label[id=Sık_2]')
    var Sık_3 = $('label[id=Sık_3]')
    var Sık_4 = $('label[id=Sık_4]')
    var Sık_5 = $('label[id=Sık_5]')
    var Sonraki_Soru = $('button[id=Sonraki_Soru]')

   
    

    $.ajax({
        url: 'Sınav-Detay.aspx/Soru_Listesi',
        dataType: 'json',
        async: false,
        type: 'POST',
        data: "{'parametre': ''}",
        contentType: 'application/json; charset=utf-8',
        success: function (data) {

            var b = 0;
            while (data.d.split('!')[b] != null) {
                if (data.d.split('!')[b] == "0") {
                    Soru_Listesi.append('<li class="treeview"><a><i class="fa fa-fw fa-question-circle"></i>' + (b + 1) + '.Soru</a></li>')
                }
                else {
                    Soru_Listesi.append('<li class="treeview"><a><i class="fa fa-fw fa-check-square-o"></i>' + (b + 1) + '.Soru</a></li>')
                }
                b++;
            }

        },
        error: function () {

            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

        }
    });
    $.ajax({
        url: 'Sınav-Detay.aspx/Soru_Getir',
        dataType: 'json',
        type: 'POST',
        data: "{'parametre': ''}",
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            console.log(data.d)
            Sonraki_Soru.attr('Simdiki_Soru_Id', data.d.split('!')[0].split('-')[4])
            Sonraki_Soru.attr('Soru_Id', data.d.split('!')[0].split('-')[5])
            Soru.append(data.d.split('!')[0].split('-')[0] + "- " + data.d.split('!')[0].split('-')[1])
            Sık_1.append(data.d.split('!')[0].split('-')[2])
            Sık_2.append(data.d.split('!')[1].split('-')[2])
            Sık_3.append(data.d.split('!')[2].split('-')[2])
            Sık_4.append(data.d.split('!')[3].split('-')[2])
            Sık_5.append(data.d.split('!')[4].split('-')[2])
            Sık_1.attr('Sık_Id', data.d.split('!')[0].split('-')[3])
            Sık_2.attr('Sık_Id', data.d.split('!')[1].split('-')[3])
            Sık_3.attr('Sık_Id', data.d.split('!')[2].split('-')[3])
            Sık_4.attr('Sık_Id', data.d.split('!')[3].split('-')[3])
            Sık_5.attr('Sık_Id', data.d.split('!')[4].split('-')[3])
           

        },
        error: function () {

            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

        }
    });

    Sonraki_Soru.click(function () {

        var selected = $("input[name='optionsRadios']:checked").parent().attr('Sık_id')

        if (selected == undefined) {
            selected = "0";
        }
 
        $.ajax({
            url: 'Sınav-Detay.aspx/Sonraki_Soru',
            dataType: 'json',
            type: 'POST',
            data: "{'parametre': '" + $(this).attr('simdiki_soru_id') + "-" + selected + "'}",
            contentType: 'application/json; charset=utf-8',
            success: function (data) {

                if (data.d =="2") {
                    window.location.href = "/Sınav.aspx"
                }
                else {

                    $.ajax({
                        url: 'Sınav-Detay.aspx/Soru_Getir',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'parametre': ''}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            Sonraki_Soru.removeAttr('Simdiki_Soru_Id')
                            Sonraki_Soru.removeAttr('Soru_Id')
                            Sonraki_Soru.attr('Simdiki_Soru_Id', data.d.split('!')[0].split('-')[4])
                            Sonraki_Soru.attr('Soru_Id', data.d.split('!')[0].split('-')[5])


                            Soru.empty();
                            Soru.append(data.d.split('!')[0].split('-')[0] + "- " + data.d.split('!')[0].split('-')[1])

                            Sık_1.empty();
                            Sık_1.append('<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1">')
                            Sık_1.append(data.d.split('!')[0].split('-')[2])

                            Sık_2.empty();
                            Sık_2.append('<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1">')
                            Sık_2.append(data.d.split('!')[1].split('-')[2])

                            Sık_3.empty();
                            Sık_3.append('<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1">')
                            Sık_3.append(data.d.split('!')[2].split('-')[2])

                            Sık_4.empty();
                            Sık_4.append('<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1">')
                            Sık_4.append(data.d.split('!')[3].split('-')[2])

                            Sık_5.empty();
                            Sık_5.append('<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1">')
                            Sık_5.append(data.d.split('!')[4].split('-')[2])


                            Sık_1.removeAttr('Sık_Id')
                            Sık_2.removeAttr('Sık_Id')
                            Sık_3.removeAttr('Sık_Id')
                            Sık_4.removeAttr('Sık_Id')
                            Sık_5.removeAttr('Sık_Id')

                            Sık_1.attr('Sık_Id', data.d.split('!')[0].split('-')[3])
                            Sık_2.attr('Sık_Id', data.d.split('!')[1].split('-')[3])
                            Sık_3.attr('Sık_Id', data.d.split('!')[2].split('-')[3])
                            Sık_4.attr('Sık_Id', data.d.split('!')[3].split('-')[3])
                            Sık_5.attr('Sık_Id', data.d.split('!')[4].split('-')[3])


                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });
                }
                
               
              

            },
            error: function () {

                alert('Talep esnasında sorun oluştu.Yeniden deneyin');

            }
        });
        $.ajax({
            url: 'Sınav-Detay.aspx/Soru_Listesi',
            dataType: 'json',
            async:false,
            type: 'POST',
            data: "{'parametre': ''}",
            contentType: 'application/json; charset=utf-8',
            success: function (data) {
          
                Soru_Listesi.empty();
                var b = 0;
                while (data.d.split('!')[b] != null) {
                    if (data.d.split('!')[b] == "0") {
                   

                        Soru_Listesi.append('<li class="treeview"><a><i class="fa fa-fw fa-question-circle"></i>' + (b + 1) + '.Soru</a></li>')

                    }
                    else {
                        

                        Soru_Listesi.append('<li class="treeview"><a><i class="fa fa-fw fa-check-square-o"></i>' + (b + 1) + '.Soru</a></li>')

                    }
                    b++;
                }

            },
            error: function () {

                alert('Talep esnasında sorun oluştu.Yeniden deneyin');

            }
        });

    });


});

