$(document).ready(function () {
    var content = $("section[id=content]");
    var Pazar = content.find($("span[name=Pazar]"));//find($('span[id=ay_yıl]')).append('<h1>asddasasd</h1>');
    var pazardiv = Pazar.parent().parent().append("<div class='overlay'></div >");
    var Cumartesi = content.find($("span[name=Cumartesi]"));
    var cumartesidiv = Cumartesi.parent().parent().append("<div class='overlay'></div >");

    var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
    var today = new Date();
    var Set_Button = $('input[id=cal-set]')
    var Yıl_DDL = $('select[id=cal-yr]')
    var Ay_DDL = $('select[id=cal-mth]')
    Set_Button.click(function () {

        alert(Yıl_DDL.find('option:selected').val())
        alert(Ay_DDL.find('option:selected').val())
    });
    var mName = ["Ocak", "Subat", "Mart", "Nisan", "Mayis", "Haziran", "Temmuz", "Agustos", "Eylul", "Ekim", "Kasim", "Aralik"];

    // (G1) DATE NOW
    var now = new Date(),
        nowMth = now.getMonth(),
        nowYear = parseInt(now.getFullYear());


    // (G2) APPEND MONTHS SELECTOR
    var month = document.getElementById("calmth");

    for (var i = 0; i < 12; i++) {

        var opt = document.createElement("option");
        opt.value = i + 1;
        opt.innerHTML = mName[i];
        if (i == nowMth) { opt.selected = true; }
        month.appendChild(opt);
    }

    // (G3) APPEND YEARS SELECTOR
    // Set to 10 years range. Change this as you like.
    var year = document.getElementById("calyr");
    for (var i = nowYear - 10; i <= nowYear + 10; i++) {
        var opt = document.createElement("option");
        opt.value = i;
        opt.innerHTML = i;
        if (i == nowYear) { opt.selected = true; }
        year.appendChild(opt);
    }


    $("a[id*=btn_addtocart_Doktor]").bind("click", function () {

      


        var bilgi = $(this).closest($('div[Id*=bilgi]'));
        var Gun_Rkm = $(bilgi).find($('[id*=gun]')).html().replace(/\&nbsp;/g, ' ');
        var Gun_Txt = $(bilgi).find($('[id*=Gun_txt]')).html().replace(/\&nbsp;/g, ' ');
        var Ay_Yıl_Txt = $(bilgi).find($('[id*=ay_yıl]')).html().replace(/\&nbsp;/g, ' ').replace('<br>', ' ').split(' ');//1 ay 3 yıl

        //Doktor_Modal
        var Dokor_Modal = $('div[Id*=Doktor_Modal]');
        var Doktor_Modal_head = $('div[Id*=doktor_modal_head]');
        var Dktr_modal_bslk = $(Doktor_Modal_head).find($('h4[Id*=Dktr_modal_bslk]'));
        Dktr_modal_bslk.empty();
        var Dktr_modal_bslk = $(Doktor_Modal_head).find($('h4[Id*=Dktr_modal_bslk]')).append(Gun_Rkm + " " + Ay_Yıl_Txt[1] + " " + Gun_Txt);

        var Dktr_Il = $(Dokor_Modal).find($('select[Id*=Dktr_Il]'));
        var Dktr_Brick = $(Dokor_Modal).find($('select[Id*=Dktr_brick]'));
        var Dktr_Unite = $(Dokor_Modal).find($('select[Id*=Dktr_Unite]'));
        var Dktr_Brans = $(Dokor_Modal).find($('select[Id*=Dktr_Brans]'));
        var Dktr_Ad = $(Dokor_Modal).find($('select[Id*=Dktr_Ad]'));
        var Dktr_Liste = $(Dokor_Modal).find($('select[Id*=Dktr_Liste]'));
        var Kullanıcı_Adı = $('div[id=Kullanıcı_Adı]').html()
        alert(Kullanıcı_Adı)



        $.ajax({
            url: 'Doktor-Listesi-Olustur.aspx/Yeni_Liste_Olustur_Listeler', //doktorları listelerken tersten listele 
            dataType: 'json',
            type: 'POST',
            data: "{'parametre': '" + Kullanıcı_Adı + "-0'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
            contentType: 'application/json; charset=utf-8',
            success: function (data) {
                Dktr_Liste.empty();

                var b = 0;
                while (data.d.split('!')[b] != null) {

                    Dktr_Liste.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                    b++;
                }
            }
        });






        var Dktr_Modal_Kaydet = Dokor_Modal.find($('button[id=Ekle]'))
        Dktr_Modal_Kaydet.click(function () {

            var Il = true, Brick = true, Unite = true, Brans = true, Ad = true, hafta_2_1 = true, hafta_4_1 = true, hafta_4_2 = true, hafta_4_3 = true;

            if (Dktr_Il.val() == "-->>Lütfen Şehir Seçiniz <<--") {
                Il = false;
                $(this).removeAttr("data-dismiss");
                Dktr_Il.parent().removeAttr("class");
                Dktr_Il.parent().attr("class", "form-group has-error");


            }
            if (Dktr_Il.val() == null) {
                Il = false;
                $(this).removeAttr("data-dismiss");
                Dktr_Il.parent().removeAttr("class");
                Dktr_Il.parent().attr("class", "form-group has-error");


            }
            if (Dktr_Brick.val() == null) {
                Brick = false;
                $(this).removeAttr("data-dismiss");
                Dktr_Brick.parent().removeAttr("class");
                Dktr_Brick.parent().attr("class", "form-group has-error");

            }

            if (Dktr_Brick.val() == "-->> Lütfen Brick Seçiniz <<--") {
                Brick = false;
                $(this).removeAttr("data-dismiss");
                Dktr_Brick.parent().removeAttr("class");
                Dktr_Brick.parent().attr("class", "form-group has-error");

            }
            if (Dktr_Unite.val() == null) {
                $(this).removeAttr("data-dismiss");
                Dktr_Unite.parent().removeAttr("class");
                Dktr_Unite.parent().attr("class", "form-group has-error");

            }
            if (Dktr_Unite.val() == "-->> Lütfen Ünite Seçiniz <<--") {
                $(this).removeAttr("data-dismiss");
                Dktr_Unite.parent().removeAttr("class");
                Dktr_Unite.parent().attr("class", "form-group has-error");

            }
            if (Dktr_Brans.val() == null) {
                Brans = false;
                $(this).removeAttr("data-dismiss");
                Dktr_Brans.parent().removeAttr("class");
                Dktr_Brans.parent().attr("class", "form-group has-error");

            }
            if (Dktr_Brans.val() == "-->> Lütfen Branş Seçiniz <<--") {
                Brans = false;
                $(this).removeAttr("data-dismiss");
                Dktr_Brans.parent().removeAttr("class");
                Dktr_Brans.parent().attr("class", "form-group has-error");

            }
            if (Dktr_Ad.val() == null) {
                Ad = false;
                $(this).removeAttr("data-dismiss");
                Dktr_Ad.parent().removeAttr("class");
                Dktr_Ad.parent().attr("class", "form-group has-error");

            }
            if (Dktr_Ad.val() == "-->> Lütfen Doktor Adı Seçiniz <<--") {
                Ad = false;
                $(this).removeAttr("data-dismiss");
                Dktr_Ad.parent().removeAttr("class");
                Dktr_Ad.parent().attr("class", "form-group has-error");
            }
            if ($(Dokor_Modal).find($('select[Id*=frekans_2_1]')).val() == "Lütfen Bir gün Seçiniz") {
                hafta_2_1 = false;
                $(this).removeAttr("data-dismiss");
                Dktr_Ad.parent().parent().find($('div[id=frekans_2_1_div]')).attr('class', 'form-group has-error');

            }
            if ($(Dokor_Modal).find($('select[Id*=frekans_4_1]')).val() == "Lütfen Bir gün Seçiniz") {
                hafta_4_1 = false;
                $(this).removeAttr("data-dismiss");
                Dktr_Ad.parent().parent().find($('div[id=frekans_4_1_div]')).attr('class', 'form-group has-error');


            }
            if ($(Dokor_Modal).find($('select[Id*=frekans_4_2]')).val() == "Lütfen Bir gün Seçiniz") {
                hafta_4_2 = false;
                $(this).removeAttr("data-dismiss");
                Dktr_Ad.parent().parent().find($('div[id=frekans_4_2_div]')).attr('class', 'form-group has-error');

            }
            if ($(Dokor_Modal).find($('select[Id*=frekans_4_3]')).val() == "Lütfen Bir gün Seçiniz") {
                hafta_4_3 = false;
                $(this).removeAttr("data-dismiss");
                Dktr_Ad.parent().parent().find($('div[id=frekans_4_3_div]')).attr('class', 'form-group has-error');

            }
            if (parseInt(Dktr_Ad.find('option:selected').attr('frekans')) == 4) {
                if (Il == true && Brick == true && Unite == true && Brans == true && Ad == true && hafta_4_1 == true && hafta_4_2 == true && hafta_4_3 == true) {

                    var Gun_Rkm = $(bilgi).find($('span[id*=gun]')).html().replace(/\&nbsp;/g, ' ');
                    var hafta41_slc_gun = hafta_41.find('option:selected').text().split(" ")[0].trim();
                    var hafta42_slc_gun = hafta_42.find('option:selected').text().split(" ")[0].trim();
                    var hafta43_slc_gun = hafta_43.find('option:selected').text().split(" ")[0].trim();

                    alert(hafta43_slc_gun);

                    var doktor_box_div_1 = bilgi.parent().parent().find($('div[id*=doktor_' + hafta41_slc_gun + '],div[id*=doktor_' + Gun_Rkm + '],div[id*=doktor_' + hafta42_slc_gun + '],div[id*=doktor_' + hafta43_slc_gun + ']'));
                    var doktor_box_div = bilgi.parent().parent().find($('div[id*=doktor_' + Gun_Rkm + ']'));


                    var satır = "<tr><td>" + Dktr_Ad.find('option:selected').text() + "</td><td>" + Dktr_Unite.find('option:selected').text() + "</td><td>" + Dktr_Brans.find('option:selected').text() + "</td><td>" + Dktr_Brick.find('option:selected').text() + "</td><td><span class='label label-waring'>Ziyret bekleniyor</span></td></tr>";


                    var a = doktor_box_div.children().children().children(), b = doktor_box_div_1.children().children().children();
                    //a.append(satır);
                    b.append(satır);
                }
            }
            if (parseInt(Dktr_Ad.find('option:selected').attr('frekans')) == 2) {
                if (Il == true && Brick == true && Unite == true && Brans == true && Ad == true && hafta_2_1 == true) {

                    //var hafta21_slc_gun = hafta_21.find('option:selected').text().split(" ")[0].trim();
                    //var Gun_Rkm = $(bilgi).find($('span[id*=gun]')).html().replace(/\&nbsp;/g, ' ');
                    //var doktor_box_div = bilgi.find($('div[id*=doktor_' + Gun_Rkm + ']'));
                    //var doktor_box_div_1 = bilgi.find($('div[id*=doktor_' + hafta21_slc_gun + ']'));
                    //var a = doktor_box_div.children().children().children().append("<tr><td>" + Dktr_Ad.find('option:selected').text() + "</td><td>" + Dktr_Unite.find('option:selected').text() + "</td><td>" + Dktr_Brans.find('option:selected').text() + "</td><td>" + Dktr_Brick.find('option:selected').text() + "</td><td><span class='label label-waring'>Ziyret bekleniyor</span></td></tr>");
                    //var b = doktor_box_div_1.children().children().children().append("<tr><td>" + Dktr_Ad.find('option:selected').text() + "</td><td>" + Dktr_Unite.find('option:selected').text() + "</td><td>" + Dktr_Brans.find('option:selected').text() + "</td><td>" + Dktr_Brick.find('option:selected').text() + "</td><td><span class='label label-waring'>Ziyret bekleniyor</span></td></tr>");


                    var Gun_Rkm = $(bilgi).find($('span[id*=gun]')).html().replace(/\&nbsp;/g, ' ');
                    var hafta21_slc_gun = hafta_21.find('option:selected').text().split(" ")[0].trim();


                    var doktor_box_div_1 = bilgi.parent().parent().find($('div[id*=doktor_' + hafta21_slc_gun + '],div[id*=doktor_' + Gun_Rkm + ']'));
                    var doktor_box_div = bilgi.parent().parent().find($('div[id*=doktor_' + Gun_Rkm + ']'));


                    var satır = "<tr><td>" + Dktr_Ad.find('option:selected').text() + "</td><td>" + Dktr_Unite.find('option:selected').text() + "</td><td>" + Dktr_Brans.find('option:selected').text() + "</td><td>" + Dktr_Brick.find('option:selected').text() + "</td><td><span class='label label-waring'>Ziyret bekleniyor</span></td></tr>";


                    var a = doktor_box_div.children().children().children(), b = doktor_box_div_1.children().children().children();
                    //a.append(satır);
                    b.append(satır);










                }


            }

            //if (Il == true && Brick == true && Unite == true && Brans == true && Ad == true && hafta_2_1 == true && hafta_4_1 == true && hafta_4_2 == true && hafta_4_3 == true) {



            // tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd

            //}


            Dktr_Modal_Kaydet.unbind('click');
        });
        Dktr_Ad.parent().removeAttr("class");
        Dktr_Ad.parent().attr("class", "form-group");
        Dktr_Brans.parent().removeAttr("class");
        Dktr_Brans.parent().attr("class", "form-group");
        Dktr_Unite.parent().removeAttr("class");
        Dktr_Unite.parent().attr("class", "form-group");
        Dktr_Brick.parent().removeAttr("class");
        Dktr_Brick.parent().attr("class", "form-group");
        Dktr_Il.parent().removeAttr("class");
        Dktr_Il.parent().attr("class", "form-group");


        $.ajax({
            url: 'ddldeneme.aspx/OrnekPost',
            dataType: 'json',
            type: 'POST',
            data: "{'parametre': '0-0'}",
            contentType: 'application/json; charset=utf-8',
            success: function (data) {
                Dktr_Il.empty();
                Dktr_Il.append("<option>-->> Lütfen Şehir Seçiniz <<--</option>")
                var b = 0;
                while (data.d.split('!')[b] != null) {

                    Dktr_Il.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                    b++;

                }

            },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
            error: function () {

                alert('Talep esnasında sorun oluştu.Yeniden deneyin');

            }
        });

        Dktr_Il.change(function () {
            Dktr_Il.parent().removeAttr("class");
            Dktr_Il.parent().attr("class", "form-group");
            $.ajax({
                url: 'ddldeneme.aspx/OrnekPost',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '1-" + $(this).val() + "'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Dktr_Brick.empty();
                    Dktr_Brick.append("<option>-->> Lütfen Brick Seçiniz <<--</option>");
                    var b = 0;
                    while (data.d.split('!')[b] != null) {
                        Dktr_Brick.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                        b++;
                    }
                    if (Dktr_Il.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Şehir Seçiniz &lt;&lt;--") {
                        Dktr_Il.parent().children().find($("select option:first-child")).remove();
                    }
                }
            });
            // tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
        })
        Dktr_Brick.change(function () {
            Dktr_Brick.parent().removeAttr("class");
            Dktr_Brick.parent().attr("class", "form-group");
            $.ajax({
                url: 'ddldeneme.aspx/OrnekPost',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '2-" + $(this).val() + "'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Dktr_Unite.empty();
                    Dktr_Unite.append("<option>-->> Lütfen Ünite Seçiniz <<--</option>");
                    var b = 0;
                    while (data.d.split('!')[b] != null) {

                        Dktr_Unite.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                        b++;
                    }
                    if (Dktr_Brick.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Brick Seçiniz &lt;&lt;--") {
                        Dktr_Brick.parent().children().find($("select option:first-child")).remove();
                    }
                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            // tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
        })
        Dktr_Unite.change(function () {
            Dktr_Unite.parent().removeAttr("class");
            Dktr_Unite.parent().attr("class", "form-group");

            $.ajax({
                url: 'ddldeneme.aspx/OrnekPost',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '3-" + $(this).val() + "'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Dktr_Brans.empty();
                    Dktr_Brans.append("<option>-->> Lütfen Branş Seçiniz <<--</option>");
                    var b = 0;
                    while (data.d.split('!')[b] != null) {


                        Dktr_Brans.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                        b++;

                    }
                    if (Dktr_Unite.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Ünite Seçiniz &lt;&lt;--") {
                        Dktr_Unite.parent().children().find($("select option:first-child")).remove();
                    }
                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });

        })
        Dktr_Brans.change(function () {
            Dktr_Brans.parent().removeAttr("class");
            Dktr_Brans.parent().attr("class", "form-group");

            $.ajax({
                url: 'ddldeneme.aspx/OrnekPost',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '4-" + $(this).val() + "-" + Dktr_Liste.find('option:selected').attr('value') + "'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Dktr_Ad.empty();
                    Dktr_Ad.append(" <option>-->> Lütfen Doktor Adı Seçiniz <<--</option>");

                    var b = 0;
                    while (data.d.split('!')[b] != null) {
                        Dktr_Ad.append("<option frekans=" + data.d.split('!')[b].split("-")[2] + " value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                        b++;
                    }
                    if (Dktr_Brans.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Branş Seçiniz &lt;&lt;--") {
                        Dktr_Brans.parent().children().find($("select option:first-child")).remove();
                    }
                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });// sadece 1 kere silecek şekilde ayarla sikim

        })//cal-yr

        var Bilgi_Mesajı = $(Dokor_Modal).find($('div[id=Bilgi_Mesajı]'));
        Bilgi_Mesajı.attr('style', 'display: none');
        var hafta_21_div = $(Dokor_Modal).find($('div[Id=frekans_2_1_div]'));
        hafta_21_div.attr('style', 'display: none');
        var hafta_41_div = $(Dokor_Modal).find($('div[Id=frekans_4_1_div]'));
        hafta_41_div.attr('style', 'display: none');
        var hafta_42_div = $(Dokor_Modal).find($('div[Id=frekans_4_2_div]'));
        hafta_42_div.attr('style', 'display: none');
        var hafta_43_div = $(Dokor_Modal).find($('div[Id=frekans_4_3_div]'));
        hafta_43_div.attr('style', 'display: none');
        var hafta_21 = $(Dokor_Modal).find($('select[Id=frekans_2_1]'));
        hafta_21.empty();
        var hafta_41 = $(Dokor_Modal).find($('select[Id=frekans_4_1]'));
        hafta_41.empty();
        var hafta_42 = $(Dokor_Modal).find($('select[Id=frekans_4_2]'));
        hafta_42.empty();
        var hafta_43 = $(Dokor_Modal).find($('select[Id=frekans_4_3]'));
        hafta_43.empty();


        Dktr_Ad.change(function () {

            $.ajax({
                url: 'ddldeneme.aspx/Frekans_modal_Doldurma',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '" + Yıl_DDL.find('option:selected').val() + "-" + Ay_DDL.find('option:selected').val() + "'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {


                    var Dokor_Modal = $('div[Id*=Doktor_Modal]');
                    var Dktr_Ad = $(Dokor_Modal).find($('select[Id*=Dktr_Ad]'));
                    var Frekans = Dktr_Ad.find('option:selected').attr('frekans')
                    var Bilgi_Mesajı = $(Dokor_Modal).find($('div[id=Bilgi_Mesajı]'))
                    var hafta_21_div = $(Dokor_Modal).find($('div[Id=frekans_2_1_div]'));
                    var hafta_41_div = $(Dokor_Modal).find($('div[Id=frekans_4_1_div]'));
                    var hafta_42_div = $(Dokor_Modal).find($('div[Id=frekans_4_2_div]'));
                    var hafta_43_div = $(Dokor_Modal).find($('div[Id=frekans_4_3_div]'));
                    var hafta_21 = $(Dokor_Modal).find($('select[Id=frekans_2_1]'));
                    var hafta_41 = $(Dokor_Modal).find($('select[Id=frekans_4_1]'));
                    var hafta_42 = $(Dokor_Modal).find($('select[Id=frekans_4_2]'));
                    var hafta_43 = $(Dokor_Modal).find($('select[Id=frekans_4_3]'));

                    if (Frekans == 2) {
                        if (data.d.split('/').length == 4) {//style="display: none;"  Bilgi_Mesajı

                            for (var i = 0; i < data.d.split('/')[3].split('*').length; i++) {
                                hafta_21.append('<option Gun_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[2].split('*')[i].split('-')[1] + '</option>')
                            }
                            hafta_21_div.removeAttr('style')


                        }
                    }
                    if (Frekans == 4) {

                        if (data.d.split('/').length == 4) {//style="display: none;"  Bilgi_Mesajı

                            for (var i = 0; i < data.d.split('/')[3].split('*').length; i++) {
                                hafta_41.append('<option Gun_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[1].split('*')[i].split('-')[1] + '</option>')
                            }
                            hafta_41_div.removeAttr('style')

                            for (var i = 0; i < data.d.split('/')[3].split('*').length; i++) {
                                hafta_42.append('<option Gun_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[2].split('*')[i].split('-')[1] + '</option>')
                            }
                            hafta_42_div.removeAttr('style')

                            for (var i = 0; i < data.d.split('/')[3].split('*').length; i++) {
                                hafta_43.append('<option Gun_Rkm=' + data.d.split('/')[3].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[3].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[3].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[3].split('*')[i].split('-')[1] + '</option>')
                            }
                            hafta_43_div.removeAttr('style')

                        }
                        if (data.d.split('/').length == 3) {//style="display: none;"  Bilgi_Mesajı
                            Bilgi_Mesajı.removeAttr('style')
                            for (var i = 0; i < data.d.split('/')[3].split('*').length; i++) {
                                hafta_41.append('<option Gun_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[1].split('*')[i].split('-')[1] + '</option>')
                            }
                            hafta_41_div.removeAttr('style')

                            for (var i = 0; i < data.d.split('/')[3].split('*').length; i++) {
                                hafta_42.append('<option Gun_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[2].split('*')[i].split('-')[1] + '</option>')
                            }
                            hafta_42_div.removeAttr('style')


                        }
                    }

                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            Dktr_Ad.unbind('change')

        })





        Dktr_Brans.empty();
        Dktr_Brick.empty();
        Dktr_Unite.empty();
        Dktr_Ad.empty();



    });

});