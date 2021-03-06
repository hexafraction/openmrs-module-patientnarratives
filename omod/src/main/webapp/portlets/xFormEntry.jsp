<%@ include file="/WEB-INF/template/include.jsp" %>

<openmrs:htmlInclude file="/moduleResources/xforms/formrunner/FormRunner.nocache.js"/>

<script type="text/javascript" src='${pageContext.request.contextPath}/dwr/engine.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/dwr/util.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/dwr/interface/DWRXformsService.js'></script>

<openmrs:htmlInclude file="/scripts/calendar/calendar.js" />
<openmrs:htmlInclude file="/scripts/timepicker/timepicker.js" />

<openmrs:htmlInclude file="/dwr/interface/DWRreCaptchaService.js" />

<c:if test="${usingJQuery}">
    <openmrs:htmlInclude file="/dwr/interface/DWRConceptService.js" />
    <openmrs:htmlInclude file="/dwr/interface/DWRPersonService.js" />
    <openmrs:htmlInclude file="/dwr/interface/DWRProviderService.js" />
    <openmrs:htmlInclude file="/scripts/jquery/autocomplete/OpenmrsAutoComplete.js" />
    <openmrs:htmlInclude file="/scripts/jquery/autocomplete/jquery.ui.autocomplete.autoSelect.js" />
</c:if>

<%--<iframe src="javascript:''" id="__gwt_historyFrame" tabIndex='-1' style="position:absolute;width:0;height:0;border:0"></iframe>--%>

<%--<script>--%>

    <%--var $j = jQuery.noConflict();--%>

    <%--$j(document).ready(function(){--%>
        <%--logging: true;--%>
        <%--$j("#submitMainForm").click(function() {--%>
            <%--submitForm();--%>
        <%--});--%>
    <%--});--%>
    <%----%>

<%--</script>--%>

<% String remoteip = request.getRemoteAddr(); %>

<script>

    var $j = jQuery.noConflict();
    var flagCaptcha = false;
    var flagDoneUpload = false;

    $j(document).ready(function(){

        logging: true;

        $j("#submitMainForm").click(function() {

            var remoteip = "<%=remoteip%>";
            var challenge = $j('#recaptcha_challenge_field').val();
            var uresponse = $j('#recaptcha_response_field').val();

            DWRreCaptchaService.validateCaptcha(challenge, uresponse, remoteip, captchaValidate);

            if(flagCaptcha==true || flagCaptcha==false){
                submitForm();
                timedRefresh();
//                alert("Thanks, Record saved!");
//                location.reload();
                return false;
            }
            else{
                alert("Captcha incorrect, please fix!");
            }

        });


        function timedRefresh(){
            setTimeout("location.reload(true);",500);
            alert("Thanks, Your Patient Narrative Record saved Successfully! New ticket has been created & Await for feedback from our care-provider team shortly!");
        }

        $j("#nextUploads").click(function() {

            var remoteip = "<%=remoteip%>";
            var challenge = $j('#recaptcha_challenge_field').val();
            var uresponse = $j('#recaptcha_response_field').val();

            DWRreCaptchaService.validateCaptcha(challenge, uresponse, remoteip, captchaValidate);

            if(flagCaptcha==true || flagCaptcha==false){
                submitForm();
                return false;
            }
            else{
                alert("Captcha incorrect, please fix!");
            }

        });
    });


    function captchaValidate(isCorrect) {

        if (isCorrect){
            flagCaptcha=true;
        }
    }

//    function doneUpload(isCorrect) {
//
//        if (isCorrect){
//            flagDoneUpload=true;
//        }
//    }

</script>


    <%--var c=document.getElementById("myCanvas");--%>
    <%--var ctx=c.getContext("2d");--%>
    <%--ctx.fillStyle="#000000";--%>
    <%--ctx.fillRect(0,0,400,200);--%>

        <div>
            <div id="purcformrunner"></div>

            <div id="formId" style="visibility:hidden;">${model.formId}</div>
            <div id="patientId" style="visibility:hidden;">${model.patientId}</div>

            <div id="dateTimeSubmitFormat" style="visibility:hidden;">${model.dateTimeSubmitFormat}</div>
            <div id="dateTimeDisplayFormat" style="visibility:hidden;">${model.dateTimeDisplayFormat}</div>

            <div id="dateSubmitFormat" style="visibility:hidden;">${model.dateSubmitFormat}</div>
            <div id="dateDisplayFormat" style="visibility:hidden;">${model.dateDisplayFormat}</div>

            <div id="entityIdName" style="visibility:hidden;">patientId</div>
            <div id="formIdName" style="visibility:hidden;">formId</div>

            <div id="entityFormDefDownloadUrlSuffix" style="visibility:hidden;">${model.entityFormDefDownloadUrlSuffix}</div>
            <div id="formDataUploadUrlSuffix" style="visibility:hidden;">${model.formDataUploadUrlSuffix}</div>
            <div id="afterSubmitUrlSuffix" style="visibility:hidden;">${model.afterSubmitUrlSuffix}</div>
            <div id="afterCancelUrlSuffix" style="visibility:hidden;">${model.afterCancelUrlSuffix}</div>
            <div id="externalSourceUrlSuffix" style="visibility:hidden;">moduleServlet/xforms/widgetValueDownload?</div>
            <div id="multimediaUrlSuffix" style="visibility:hidden;">moduleServlet/xforms/multimediaDownload</div>

            <div id="defaultFontFamily" style="visibility:hidden;">${model.defaultFontFamily}</div>
            <div id="defaultFontSize" style="visibility:hidden;">${model.defaultFontSize}</div>
            <div id="defaultGroupBoxHeaderBgColor" style="visibility:hidden;">${model.defaultGroupBoxHeaderBgColor}</div>

            <div id="appendEntityIdAfterSubmit" style="visibility:hidden;">1</div>
            <div id="appendEntityIdAfterCancel" style="visibility:hidden;">1</div>

            <div id="timeSubmitFormat" style="visibility:hidden;">${model.timeSubmitFormat}</div>
            <div id="timeDisplayFormat" style="visibility:hidden;">${model.timeDisplayFormat}</div>

            <div id="showSubmitSuccessMsg" style="visibility:hidden;">${model.showSubmitSuccessMsg}</div>

            <div id="localeKey" style="visibility:hidden;">${model.localeKey}</div>
            <div id="decimalSeparators" style="visibility:hidden;">${model.decimalSeparators}</div>
            <div id="formatXml" style="visibility:hidden;">${model.formatXml}</div>

        </div>

<script language="javascript">

var searchElement;
var conceptSearchElement;
var providerSearchElement;
var locationSearchElement;
var personSearchElement;
var options;

var PurcformsText = {
    file: "<spring:message code="xforms.file" />",
        view: "<spring:message code="xforms.view" />",
        item: "<spring:message code="xforms.item" />",
        tools: "<spring:message code="xforms.tools" />",
        help: "<spring:message code="xforms.help" />",
        newItem: "<spring:message code="xforms.newItem" />",
        open: "<spring:message code="xforms.open" />",
        save: "<spring:message code="xforms.save" />",
        saveAs: "<spring:message code="xforms.saveAs" />",

        openLayout: "<spring:message code="xforms.foropenLayoutms" />",
        saveLayout: "<spring:message code="xforms.saveLayout" />",
        openLanguageText: "<spring:message code="xforms.openLanguageText" />",
        saveLanguageText: "<spring:message code="xforms.saveLanguageText" />",
        close: "<spring:message code="xforms.close" />",

        refresh: "<spring:message code="xforms.refresh" />",
        addNew: "<spring:message code="xforms.addNew" />",
        addNewChild: "<spring:message code="xforms.addNewChild" />",
        deleteSelected: "<spring:message code="xforms.deleteSelected" />",
        moveUp: "<spring:message code="xforms.moveUp" />",
        moveDown: "<spring:message code="xforms.moveDown" />",
        cut: "<spring:message code="xforms.cut" />",
        copy: "<spring:message code="xforms.copy" />",
        paste: "<spring:message code="xforms.paste" />",

        format: "<spring:message code="xforms.format" />",
        languages: "<spring:message code="xforms.languages" />",
        options: "<spring:message code="xforms.options" />",

        helpContents: "<spring:message code="xforms.helpContents" />",
        about: "<spring:message code="xforms.about" />",

        forms: "<spring:message code="xforms.forms" />",
        widgetProperties: "<spring:message code="xforms.widgetProperties" />",
        properties: "<spring:message code="xforms.properties" />",
        xformsSource: "<spring:message code="xforms.xformsSource" />",
        designSurface: "<spring:message code="xforms.designSurface" />",
        layoutXml: "<spring:message code="xforms.layoutXml" />",
        languageXml: "<spring:message code="xforms.languageXml" />",
        preview: "<spring:message code="xforms.preview" />",
        modelXml: "<spring:message code="xforms.modelXml" />",

        text: "<spring:message code="xforms.text" />",
        helpText: "<spring:message code="xforms.helpText" />",
        type: "<spring:message code="xforms.type" />",
        binding: "<spring:message code="xforms.binding" />",
        visible: "<spring:message code="xforms.visible" />",
        enabled: "<spring:message code="xforms.enabled" />",
        locked: "<spring:message code="xforms.locked" />",
        required: "<spring:message code="xforms.required" />",
        defaultValue: "<spring:message code="xforms.defaultValue" />",
        descriptionTemplate: "<spring:message code="xforms.descriptionTemplate" />",

        language: "<spring:message code="xforms.language" />",
        skipLogic: "<spring:message code="xforms.skipLogic" />",
        validationLogic: "<spring:message code="xforms.validationLogic" />",
        dynamicLists: "<spring:message code="xforms.dynamicLists" />",

        valuesFor: "<spring:message code="xforms.valuesFor" />",
        whenAnswerFor: "<spring:message code="xforms.whenAnswerFor" />",
        isEqualTo: "<spring:message code="xforms.isEqualTo" />",
        forQuestion: "<spring:message code="xforms.forQuestion" />",
        enable: "<spring:message code="xforms.enable" />",
        disable: "<spring:message code="xforms.disable" />",
        show: "<spring:message code="xforms.show" />",
        hide: "<spring:message code="xforms.hide" />",
        makeRequired: "<spring:message code="xforms.makeRequired" />",

        when: "<spring:message code="xforms.when" />",
        ofTheFollowingApply: "<spring:message code="xforms.ofTheFollowingApply" />",
        all: "<spring:message code="xforms.all" />",
        any: "<spring:message code="xforms.any" />",
        none: "<spring:message code="xforms.none" />",
        notAll: "<spring:message code="xforms.notAll" />",

        addNewCondition: "<spring:message code="xforms.addNewCondition" />",

        isEqualTo: "<spring:message code="xforms.isEqualTo" />",
        isNotEqual: "<spring:message code="xforms.isNotEqual" />",
        isLessThan: "<spring:message code="xforms.isLessThan" />",
        isLessThanOrEqual: "<spring:message code="xforms.isLessThanOrEqual" />",
        isGreaterThan: "<spring:message code="xforms.isGreaterThan" />",
        isGreaterThanOrEqual: "<spring:message code="xforms.isGreaterThanOrEqual" />",
        isNull: "<spring:message code="xforms.isNull" />",
        isNotNull: "<spring:message code="xforms.isNotNull" />",
        isInList: "<spring:message code="xforms.isInList" />",
        isNotInList: "<spring:message code="xforms.isNotInList" />",
        startsWith: "<spring:message code="xforms.startsWith" />",
        doesNotStartWith: "<spring:message code="xforms.doesNotStartWith" />",
        endsWith: "<spring:message code="xforms.endsWith" />",
        doesNotEndWith: "<spring:message code="xforms.doesNotEndWith" />",
        contains: "<spring:message code="xforms.contains" />",
        doesNotContain: "<spring:message code="xforms.doesNotContain" />",
        isBetween: "<spring:message code="xforms.isBetween" />",
        isNotBetween: "<spring:message code="xforms.isNotBetween" />",

        isValidWhen: "<spring:message code="xforms.isValidWhen" />",
        errorMessage: "<spring:message code="xforms.errorMessage" />",
        question: "<spring:message code="xforms.question" />",

        addField: "<spring:message code="xforms.addField" />",
        submit: "<spring:message code="xforms.submit" />",
        addWidget: "<spring:message code="xforms.addWidget" />",
        newTab: "<spring:message code="xforms.newTab" />",
        deleteTab: "<spring:message code="xforms.deleteTab" />",
        selectAll: "<spring:message code="xforms.selectAll" />",
        load: "<spring:message code="xforms.load" />",

        label: "<spring:message code="xforms.label" />",
        textBox: "<spring:message code="xforms.textBox" />",
        checkBox: "<spring:message code="xforms.checkBox" />",
        radioButton: "<spring:message code="xforms.radioButton" />",
        dropdownList: "<spring:message code="xforms.dropdownList" />",
        textArea: "<spring:message code="xforms.textArea" />",
        button: "<spring:message code="xforms.button" />",
        datePicker: "<spring:message code="xforms.datePicker" />",
        groupBox: "<spring:message code="xforms.groupBox" />",
        repeatSection: "<spring:message code="xforms.repeatSection" />",
        picture: "<spring:message code="xforms.picture" />",
        videoAudio: "<spring:message code="xforms.videoAudio" />",
        listBox: "<spring:message code="xforms.listBox" />",

        deleteWidgetPrompt: "<spring:message code="xforms.deleteWidgetPrompt" />",
        deleteTreeItemPrompt: "<spring:message code="xforms.deleteTreeItemPrompt" />",
        selectDeleteItem: "<spring:message code="xforms.selectDeleteItem" />",

        selectedPage: "<spring:message code="xforms.selectedPage" />",
        shouldNotSharePageBinding: "<spring:message code="xforms.shouldNotSharePageBinding" />",
        selectedQuestion: "<spring:message code="xforms.selectedQuestion" />",
        shouldNotShareQuestionBinding: "<spring:message code="xforms.shouldNotShareQuestionBinding" />",
        selectedOption: "<spring:message code="xforms.selectedOption" />",
        shouldNotShareOptionBinding: "<spring:message code="xforms.shouldNotShareOptionBinding" />",
        newForm: "<spring:message code="xforms.newForm" />",
        page: "<spring:message code="xforms.page" />",
        option: "<spring:message code="xforms.option" />",
        noDataFound: "<spring:message code="xforms.noDataFound" />",

        formSaveSuccess: "<spring:message code="xforms.formSaveSuccess" />",
        selectSaveItem: "<spring:message code="xforms.selectSaveItem" />",
        deleteAllWidgetsFirst: "<spring:message code="xforms.deleteAllWidgetsFirst" />",
        deleteAllTabWidgetsFirst: "<spring:message code="xforms.deleteAllTabWidgetsFirst" />",
        cantDeleteAllTabs: "<spring:message code="xforms.cantDeleteAllTabs" />",
        noFormId: "<spring:message code="xforms.noFormId" />",
        divFound: "<spring:message code="xforms.noFormId" />",
        noFormLayout: "<spring:message code="xforms.noFormLayout" />",
        formSubmitSuccess: "<spring:message code="xforms.formSubmitSuccess" />",
        missingDataNode: "<spring:message code="xforms.missingDataNode" />",

        openingForm: "<spring:message code="xforms.openingForm" />",
        openingFormLayout: "<spring:message code="xforms.openingFormLayout" />",
        savingForm: "<spring:message code="xforms.savingForm" />",
        savingFormLayout: "<spring:message code="xforms.savingFormLayout" />",
        refreshingForm: "<spring:message code="xforms.refreshingForm" />",
        translatingFormLanguage: "<spring:message code="xforms.translatingFormLanguage" />",
        savingLanguageText: "<spring:message code="xforms.savingLanguageText" />",
        refreshingDesignSurface: "<spring:message code="xforms.refreshingDesignSurface" />",
        loadingDesignSurface: "<spring:message code="xforms.loadingDesignSurface" />",
        refreshingPreview: "<spring:message code="xforms.refreshingPreview" />",

        count: "<spring:message code="xforms.count" />",
        clickToPlay: "<spring:message code="xforms.clickToPlay" />",
        loadingPreview: "<spring:message code="xforms.loadingPreview" />",
        unexpectedFailure: "<spring:message code="xforms.unexpectedFailure" />",
        uncaughtException: "<spring:message code="xforms.uncaughtException" />",
        causedBy: "<spring:message code="xforms.causedBy" />",
        openFile: "<spring:message code="xforms.openFile" />",
        saveFileAs: "<spring:message code="xforms.saveFileAs" />",

        alignLeft: "<spring:message code="xforms.alignLeft" />",
        alignRight: "<spring:message code="xforms.alignRight" />",
        alignTop: "<spring:message code="xforms.alignTop" />",
        alignBottom: "<spring:message code="xforms.alignBottom" />",
        makeSameWidth: "<spring:message code="xforms.makeSameWidth" />",
        makeSameHeight: "<spring:message code="xforms.makeSameHeight" />",
        makeSameSize: "<spring:message code="xforms.makeSameSize" />",
        layout: "<spring:message code="xforms.layout" />",
        deleteTabPrompt: "<spring:message code="xforms.deleteTabPrompt" />",

        text: "<spring:message code="xforms.text" />",
        toolTip: "<spring:message code="xforms.toolTip" />",
        childBinding: "<spring:message code="xforms.childBinding" />",
        width: "<spring:message code="xforms.width" />",
        height: "<spring:message code="xforms.height" />",
        left: "<spring:message code="xforms.left" />",
        top: "<spring:message code="xforms.top" />",
        tabIndex: "<spring:message code="xforms.tabIndex" />",
        repeat: "<spring:message code="xforms.repeat" />",
        externalSource: "<spring:message code="xforms.externalSource" />",
        displayField: "<spring:message code="xforms.displayField" />",
        valueField: "<spring:message code="xforms.valueField" />",
        fontFamily: "<spring:message code="xforms.fontFamily" />",
        foreColor: "<spring:message code="xforms.foreColor" />",
        fontWeight: "<spring:message code="xforms.fontWeight" />",
        fontStyle: "<spring:message code="xforms.fontStyle" />",
        fontSize: "<spring:message code="xforms.fontSize" />",
        textDecoration: "<spring:message code="xforms.textDecoration" />",
        textAlign: "<spring:message code="xforms.textAlign" />",
        backgroundColor: "<spring:message code="xforms.backgroundColor" />",
        borderStyle: "<spring:message code="xforms.borderStyle" />",
        borderWidth: "<spring:message code="xforms.borderWidth" />",
        borderColor: "<spring:message code="xforms.borderColor" />",
        aboutMessage: "<spring:message code="xforms.aboutMessage" />",
        more: "<spring:message code="xforms.more" />",
        requiredErrorMsg: "<spring:message code="xforms.requiredErrorMsg" />",
        questionTextDesc: "<spring:message code="xforms.questionTextDesc" />",
        questionDescDesc: "<spring:message code="xforms.questionDescDesc" />",
        questionIdDesc: "<spring:message code="xforms.questionIdDesc" />",
        defaultValDesc: "<spring:message code="xforms.defaultValDesc" />",
        questionTypeDesc: "<spring:message code="xforms.questionTypeDesc" />",
        qtnTypeText: "<spring:message code="xforms.qtnTypeText" />",
        qtnTypeNumber: "<spring:message code="xforms.qtnTypeNumber" />",
        qtnTypeDecimal: "<spring:message code="xforms.qtnTypeDecimal" />",
        qtnTypeDate: "<spring:message code="xforms.qtnTypeDate" />",
        qtnTypeTime: "<spring:message code="xforms.qtnTypeTime" />",
        qtnTypeDateTime: "<spring:message code="xforms.qtnTypeDateTime" />",
        qtnTypeBoolean: "<spring:message code="xforms.qtnTypeBoolean" />",
        qtnTypeSingleSelect: "<spring:message code="xforms.qtnTypeSingleSelect" />",
        qtnTypeMultSelect: "<spring:message code="xforms.qtnTypeMultSelect" />",
        qtnTypeRepeat: "<spring:message code="xforms.qtnTypeRepeat" />",
        qtnTypePicture: "<spring:message code="xforms.qtnTypePicture" />",
        qtnTypeVideo: "<spring:message code="xforms.qtnTypeVideo" />",
        qtnTypeAudio: "<spring:message code="xforms.qtnTypeAudio" />",
        qtnTypeSingleSelectDynamic: "<spring:message code="xforms.qtnTypeSingleSelectDynamic" />",
        deleteCondition: "<spring:message code="xforms.deleteCondition" />",
        addCondition: "<spring:message code="xforms.addCondition" />",
        value: "<spring:message code="xforms.value" />",
        questionValue: "<spring:message code="xforms.questionValue" />",
        and: "<spring:message code="xforms.and" />",
        deleteItemPrompt: "<spring:message code="xforms.deleteItemPrompt" />",
        changeWidgetTypePrompt: "<spring:message code="xforms.changeWidgetTypePrompt" />",
        removeRowPrompt: "<spring:message code="xforms.removeRowPrompt" />",
        remove: "<spring:message code="xforms.remove" />",
        browse: "<spring:message code="xforms.browse" />",
        clear: "<spring:message code="xforms.clear" />",
        deleteItem: "<spring:message code="xforms.deleteItem" />",
        cancel: "<spring:message code="xforms.cancel" />",
        clickToAddNewCondition: "<spring:message code="xforms.clickToAddNewCondition" />",
        qtnTypeGPS: "<spring:message code="xforms.qtnTypeGPS" />",
        qtnTypeBarcode: "<spring:message code="xforms.qtnTypeBarcode" />",
        qtnTypeGroup: "<spring:message code="xforms.qtnTypeGroup" />",
        palette: "<spring:message code="xforms.palette" />",
        saveAsXhtml: "<spring:message code="xforms.saveAsXhtml" />",
        groupWidgets: "<spring:message code="xforms.groupWidgets" />",
        action: "<spring:message code="xforms.action" />",
        submitting: "<spring:message code="xforms.submitting" />",
        authenticationPrompt: "<spring:message code="xforms.authenticationPrompt" />",
        invalidUser: "<spring:message code="xforms.invalidUser" />",
        login: "<spring:message code="xforms.login" />",
        userName: "<spring:message code="xforms.userName" />",
        password: "<spring:message code="xforms.password" />",
        noSelection: "<spring:message code="xforms.noSelection" />",
        cancelFormPrompt: "<spring:message code="xforms.cancelFormPrompt" />",
        print: "<spring:message code="xforms.print" />",
        yes: "<spring:message code="xforms.yes" />",
        no: "<spring:message code="xforms.no" />",
        searchServer: "<spring:message code="xforms.searchServer" />",
        recording: "<spring:message code="xforms.recording" />",
        search: "<spring:message code="xforms.search" />",
        processingMsg: "<spring:message code="xforms.processingMsg" />",
        length: "<spring:message code="xforms.length" />",
        clickForOtherQuestions: "<spring:message code="xforms.clickForOtherQuestions" />",
        ok: "<spring:message code="xforms.ok" />",
        undo: "<spring:message code="xforms.undo" />",
        redo: "<spring:message code="xforms.redo" />",
        loading: "<spring:message code="xforms.loading" />",
        allQuestions: "<spring:message code="xforms.allQuestions" />",
        selectedQuestions: "<spring:message code="xforms.selectedQuestions" />",
        otherQuestions: "<spring:message code="xforms.otherQuestions" />",
        wrongFormat: "<spring:message code="xforms.wrongFormat" />",
        timeWidget: "<spring:message code="xforms.timeWidget" />",
        dateTimeWidget: "<spring:message code="xforms.dateTimeWidget" />",
        lockWidgets: "<spring:message code="xforms.lockWidgets" />",
        unLockWidgets: "<spring:message code="xforms.unLockWidgets" />",
        changeWidgetH: "<spring:message code="xforms.changeWidgetH" />",
        changeWidgetV: "<spring:message code="xforms.changeWidgetV" />",
        changeToTextBoxWidget: "<spring:message code="xforms.changeToTextBoxWidget" />",
        saveAsPurcForm: "<spring:message code="xforms.saveAsPurcForm" />",
        localeChangePrompt: "<spring:message code="xforms.localeChangePrompt" />",
        javaScriptSource: "<spring:message code="xforms.javaScriptSource" />",
        calculation: "<spring:message code="xforms.calculation" />",
        id: "<spring:message code="xforms.id" />",
        formKey: "<spring:message code="xforms.formKey" />",
        logo: "<spring:message code="xforms.logo" />",
        filterField: "<spring:message code="xforms.filterField" />",
        table: "<spring:message code="xforms.table" />",
        horizontalLine: "<spring:message code="xforms.horizontalLine" />",
        verticalLine: "<spring:message code="xforms.verticalLine" />",
        addRowsBelow: "<spring:message code="xforms.addRowsBelow" />",
        addRowsAbove: "<spring:message code="xforms.addRowsAbove" />",
        addColumnsRight: "<spring:message code="xforms.addColumnsRight" />",
        addColumnsLeft: "<spring:message code="xforms.addColumnsLeft" />",
        numberOfRowsPrompt: "<spring:message code="xforms.numberOfRowsPrompt" />",
        numberOfColumnsPrompt: "<spring:message code="xforms.numberOfColumnsPrompt" />",
        deleteColumn: "<spring:message code="xforms.deleteColumn" />",
        deleteRow: "<spring:message code="xforms.deleteRow" />",
        repeatChildDataNodeNotFound: "<spring:message code="xforms.repeatChildDataNodeNotFound" />",
        selectedFormField: "<spring:message code="xforms.selectedFormField" />",
        edit: "<spring:message code="xforms.edit" />",
        find: "<spring:message code="xforms.find" />",
        css: "<spring:message code="xforms.css" />",
        bold: "<spring:message code="xforms.bold" />",
        italic: "<spring:message code="xforms.italic" />",
        underline: "<spring:message code="xforms.underline" />",
        mergeCells: "<spring:message code="xforms.mergeCells" />"
};

function initialize(){

}

function isUserAuthenticated(){
    DWRXformsService.isAuthenticated(checkIfLoggedInCallback);
}

function authenticateUser(username, password){
    DWRXformsService.authenticate(username,password,checkIfLoggedInCallback);
}

function checkIfLoggedInCallback(isLoggedIn) {
    authenticationCallback(isLoggedIn);
}

</script>



