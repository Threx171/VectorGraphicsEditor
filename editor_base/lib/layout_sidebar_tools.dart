import 'package:flutter/material.dart';
import 'package:flutter_cupertino_desktop_kit/cdk.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'app_data.dart';
import 'util_button_icon.dart';

class LayoutSidebarTools extends StatelessWidget {
  const LayoutSidebarTools({super.key});

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context);
    CDKTheme theme = CDKThemeNotifier.of(context)!.changeNotifier;
    CDKFieldNumeric fieldNumeric = CDKFieldNumeric(
      value: appData.docSize.width,
      min: 100,
      max: 2500,
      units: "px",
      increment: 100,
      decimals: 0,
      onValueChanged: (value) {
        appData.setDocWidth(value);
      },
    );
    CDKButtonColor buttonColor = CDKButtonColor(
      color: Colors.black,
    );

    List<String> tools = ["pointer_shapes", "shape_drawing", "view_grab"];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: tools.map((tool) {
        Color iconColor = theme.isLight
            ? appData.toolSelected == tool
                ? theme.accent
                : CDKTheme.grey800
            : appData.toolSelected == tool
                ? CDKTheme.white
                : CDKTheme.grey;

        return Container(
          padding: const EdgeInsets.only(top: 2, left: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UtilButtonIcon(
                size: 24,
                isSelected: appData.toolSelected == tool,
                onPressed: () {
                  appData.setToolSelected(tool);
                },
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: SvgPicture.asset('assets/images/$tool.svg',
                      colorFilter:
                          ColorFilter.mode(iconColor, BlendMode.srcIn)),
                ),
              ),
              if (tool == "shape_drawing" && appData.toolSelected == tool) ...[
                Text("Stroke width: ", style: TextStyle(fontSize: 12)),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                        width: 60,
                        child: CDKFieldNumeric(
                          value: 15,
                          decimals: 0,
                          min: -2,
                          max: 1.5,
                          increment: 0.15,
                          units: "px",
                          onValueChanged: (double value) {},
                        ))),
                Text("Stroke color: ", style: TextStyle(fontSize: 12)),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: ValueListenableBuilder<Color>(
                        valueListenable: appData.valueColorNotifier,
                        builder: (context, value, child) {
                          return CDKButtonColor(
                              color: Colors.black, onPressed: () {});
                        })),
              ],
            ],
          ),
        );
      }).toList(),
    );
  }
}
