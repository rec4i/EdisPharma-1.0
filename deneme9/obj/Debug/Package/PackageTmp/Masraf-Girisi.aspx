<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Masraf-Girisi.aspx.cs" Inherits="deneme9.Masraf_Girisi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="box">
        <div class="box-body">
            <div class="row">
                <div class="col-xs-6">
                    <div class="form-group">
                        <label>Select</label>
                        <select class="form-control"></select>
                    </div>
                </div>
                <div class="col-xs-6">
                    <div class="form-group">
                        <label>Select</label>
                        <select class="form-control"></select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <div class="form-group">
                        <label>Select</label>
                        <select class="form-control"></select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <div class="form-group">
                        <label>Select</label>
                        <select class="form-control"></select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <div class="form-group">
                        <label>Date:</label>

                        <asp:TextBox ID="TextBox1" class="form-control pull-right" TextMode="Date" runat="server"></asp:TextBox>
                    </div>
                    <!-- /.input group -->

                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <div class="form-group">
                        <label>Select</label>
                        <select class="form-control"></select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <div class="form-group">
                        <label>Textarea</label>
                        <textarea class="form-control" rows="3" placeholder="Enter ..."></textarea>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <div class="form-group">
                        <label>Select</label>
                        <select class="form-control"></select>

                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <div class="form-group">
                        <button type="button" class="btn btn-block btn-info btn-lg">Info</button>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-5 ">
                    <div class="form-group">
                        <asp:TextBox ID="TextBox2" class="form-control" TextMode="Date" runat="server"></asp:TextBox>


                    </div>
                </div>
                <div class="col-xs-5 ">
                    <div class="form-group">
                        <asp:TextBox ID="TextBox3" class="form-control" TextMode="Date" runat="server"></asp:TextBox>


                    </div>
                </div>
                <div class="col-xs-2 ">
                    <div class="form-group">
                        <input id="cal_set" type="button" class="btn btn-block btn-info" value="SET">
                    </div>
                </div>
            </div>

        </div>
        <div class="box-footer">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box-body no-padding table-responsive">
                        <div class="box">
                            <table id="Eczane_Frekans_Kontrol_Table" class="table table-condensed">
                                <tbody>
                                    <tr>
                                        <th>Doktor Adı</th>
                                        <th>Masraf Türü</th>
                                        <th>Acıklama</th>
                                        <th>Tarih</th>
                                        <th>Tutar</th>
                                    </tr>
                                    <tr>
                                        <td>Doktor Adı</td>
                                        <td>Masraf Türü</td>
                                        <td>Acıklama</td>
                                        <td>Tarih</td>
                                        <td>Tutar</td>
                                    </tr>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


</asp:Content>
