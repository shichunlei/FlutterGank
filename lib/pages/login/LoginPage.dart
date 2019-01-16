import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:FlutterGank/common/GlobalConfig.dart';
import 'package:FlutterGank/utils/sp_util.dart';
import 'package:FlutterGank/utils/widgets_utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<ScaffoldState> registKey = GlobalKey();

  String _phoneNum = '';

  String _verifyCode = '';

  Widget _buildPhoneEdit() {
    var node = FocusNode();
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: TextField(
        onChanged: (str) {
          _phoneNum = str;
          setState(() {});
        },
        decoration: InputDecoration(
            hintText: GlobalConfig.inputNice,
            labelText: GlobalConfig.nice,
            hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey)),
        maxLines: 1,
        maxLength: 11,
        //键盘展示为号码
        keyboardType: TextInputType.phone,
        //只能输入数字
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly,
        ],
        onSubmitted: (text) {
          FocusScope.of(context).reparentIfNeeded(node);
        },
      ),
    );
  }

  Widget _buildVerifyCodeEdit() {
    var node = FocusNode();
    Widget verifyCodeEdit = TextField(
      onChanged: (str) {
        _verifyCode = str;
        setState(() {});
      },
      decoration: InputDecoration(
          hintText: GlobalConfig.inputCode,
          labelText: GlobalConfig.pwd,
          hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey)),
      maxLines: 1,
      maxLength: 6,
      obscureText: true,
      // 键盘展示为数字
      keyboardType: TextInputType.number,
      // 只能输入数字
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly,
      ],
      onSubmitted: (text) {
        FocusScope.of(context).reparentIfNeeded(node);
      },
    );

    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0.0),
      child: Stack(
        children: <Widget>[
          verifyCodeEdit,
        ],
      ),
    );
  }

  Widget _buildRegister() {
    return Padding(
      padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
      child: RaisedButton(
        padding: EdgeInsets.fromLTRB(130.0, 10.0, 130.0, 10.0),
        color: GlobalConfig.colorPrimary,
        textColor: Colors.white,
        disabledColor: Colors.blue[100],
        onPressed: () {
          WidgetsUtil.buildLoadingDialog(context, "正在登陆...");
          Navigator.of(context).pop();
          SPUtil.saveBool("is_login", true);
          Navigator.of(context).pop();
        },
        child: Text(
          GlobalConfig.loginSubView,
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildTips() {
    return Padding(
      padding: const EdgeInsets.only(
          left: 40.0, right: 40.0, top: 50.0, bottom: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, //子组件的排列方式为主轴两端对齐
        children: <Widget>[
          Image.asset(
            'images/logo.png',
            width: 60.0,
            height: 60.0,
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        _buildTips(),
        _buildPhoneEdit(),
        _buildVerifyCodeEdit(),
        _buildRegister(),
      ],
    );
  }

  showTips() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
              child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text('没有相关接口，这是一个纯UI界面，提供部分交互体验',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 24.0))));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        key: registKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(GlobalConfig.githubLogin),
          actions: <Widget>[
            InkWell(
              child: Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(GlobalConfig.pwdLogin),
              ),
              onTap: () {
                //WidgetsUtil.buildShareBottomPop(context);
              },
            )
          ],
        ),
        body: _buildBody(),
      ),
    );
  }
}
