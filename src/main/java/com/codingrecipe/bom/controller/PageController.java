package com.codingrecipe.bom.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.Mapping;

@Controller
public class PageController {

    @GetMapping("/codeSearch")
    public String codeSearch() {
        return "codeSearch";
    }

}
