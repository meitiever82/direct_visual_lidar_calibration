#include <iostream>
#include "tinyxml2.h"

int main() {
    tinyxml2::XMLDocument doc;
    tinyxml2::XMLElement* root = doc.NewElement("Root");
    doc.InsertEndChild(root);

    tinyxml2::XMLElement* element = doc.NewElement("Element");
    element->SetText("Hello, TinyXML2!");
    root->InsertEndChild(element);

    doc.SaveFile("output.xml");

    std::cout << "XML file created successfully." << std::endl;

    return 0;
}