
//增加菜单的点击弹出，点击收回的动作。
$(".list-group-item").click(function () {
    if ($(this).find("ul")) {
        $(this).toggleClass("tree-closed");
        if ($(this).hasClass("tree-closed")) {
            $("ul", this).hide("fast");
        } else {
            $("ul", this).show("fast");
        }
    }
});

var href=window.location.href;
var patternUser = new RegExp("/user/");
var patternRole = new RegExp("/role/");
var patternPermission = new RegExp("/permission/");
var patternAuth = new RegExp("/auth/");
var patternAdvertisement = new RegExp("/auth_adv/");
var patternProject = new RegExp("/auth_project/");
var patternCert = new RegExp("/cert/");
var patternType = new RegExp("/type/");
var patternProcess = new RegExp("/process/");

var rightManager=document.getElementById("menu1");
var businessAudit=document.getElementById("menu2");
var businessManage=document.getElementById("menu3");


if(patternUser.test(href)){
    var aUser=document.getElementById("menu1menuItem0");
    aUser.style.color="red";
    $(rightManager).removeClass("tree-closed");
    $("ul",$(rightManager)).show("fast");
    $(businessAudit).addClass("tree-closed");
    $("ul",$(businessAudit)).hide("fast");
    $(businessManage).addClass("tree-closed");
    $("ul",$(businessManage)).hide("fast");
}

if(patternRole.test(href)){
    var aRole=document.getElementById("menu1menuItem1");
    aRole.style.color="red";
    $(rightManager).removeClass("tree-closed");
    $("ul",$(rightManager)).show("fast");
    $(businessAudit).addClass("tree-closed");
    $("ul",$(businessAudit)).hide("fast");
    $(businessManage).addClass("tree-closed");
    $("ul",$(businessManage)).hide("fast");
}

if(patternPermission.test(href)){
    var aPermission=document.getElementById("menu1menuItem2");
    aPermission.style.color="red";
    $(rightManager).removeClass("tree-closed");
    $("ul",$(rightManager)).show("fast");
    $(businessAudit).addClass("tree-closed");
    $("ul",$(businessAudit)).hide("fast");
    $(businessManage).addClass("tree-closed");
    $("ul",$(businessManage)).hide("fast");
}

if(patternAuth.test(href)){
    var aAuth=document.getElementById("menu2menuItem0");
    aAuth.style.color="red";
    $(rightManager).addClass("tree-closed");
    $("ul",$(rightManager)).hide("fast");
    $(businessAudit).removeClass("tree-closed");
    $("ul",$(businessAudit)).show("fast");
    $(businessManage).addClass("tree-closed");
    $("ul",$(businessManage)).hide("fast");
}

if(patternAdvertisement.test(href)){
    var aAdvertisement=document.getElementById("menu2menuItem1");
    aAdvertisement.style.color="red";
    $(rightManager).addClass("tree-closed");
    $("ul",$(rightManager)).hide("fast");
    $(businessAudit).removeClass("tree-closed");
    $("ul",$(businessAudit)).show("fast");
    $(businessManage).addClass("tree-closed");
    $("ul",$(businessManage)).hide("fast");
}

if(patternProject.test(href)){
    var aProject=document.getElementById("menu2menuItem2");
    aProject.style.color="red";
    $(rightManager).addClass("tree-closed");
    $("ul",$(rightManager)).hide("fast");
    $(businessAudit).removeClass("tree-closed");
    $("ul",$(businessAudit)).show("fast");
    $(businessManage).addClass("tree-closed");
    $("ul",$(businessManage)).hide("fast");
}

if(patternCert.test(href)){
    var aCert=document.getElementById("menu3menuItem0");
    aCert.style.color="red";
    $(rightManager).addClass("tree-closed");
    $("ul",$(rightManager)).hide("fast");
    $(businessAudit).addClass("tree-closed");
    $("ul",$(businessAudit)).hide("fast");
    $(businessManage).removeClass("tree-closed");
    $("ul",$(businessManage)).show("fast");
}

if(patternType.test(href)){
    var aType=document.getElementById("menu3menuItem1");
    aType.style.color="red";
    $(rightManager).addClass("tree-closed");
    $("ul",$(rightManager)).hide("fast");
    $(businessAudit).addClass("tree-closed");
    $("ul",$(businessAudit)).hide("fast");
    $(businessManage).removeClass("tree-closed");
    $("ul",$(businessManage)).show("fast");
}

if(patternProcess.test(href)){
    var aProcess=document.getElementById("menu3menuItem2");
    aProcess.style.color="red";
    $(rightManager).addClass("tree-closed");
    $("ul",$(rightManager)).hide("fast");
    $(businessAudit).addClass("tree-closed");
    $("ul",$(businessAudit)).hide("fast");
    $(businessManage).removeClass("tree-closed");
    $("ul",$(businessManage)).show("fast");
}



