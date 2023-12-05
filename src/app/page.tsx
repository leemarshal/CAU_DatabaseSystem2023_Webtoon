'use client'
import React from "react";
import ToolBar from "./home/components/ToolBar";
import SectionTitleBar from "./home/components/SectionTitleBar";
import HorizontalComicList from "./home/components/HorizontalComicList";
import VerticalComicList from "./home/components/VerticalComicList";

export default function Page() {
  const TOOLBAR_HEIGHT = 70

  //todo: DB 연결
  const comics = [
    {id:1, title:"Test", thumb:"https://source.unsplash.com/500x500"},
    {id:2, title:"Test", thumb:"https://source.unsplash.com/500x500"},
    {id:3, title:"Test", thumb:"https://source.unsplash.com/500x500"},
    {id:4, title:"Test", thumb:"https://source.unsplash.com/500x500"},
  ]

  return <>
    <ToolBar title={"웹툰 서비스 데모"} height={TOOLBAR_HEIGHT}/>
    <div style={{paddingTop: TOOLBAR_HEIGHT, background: "white"}}>
      <SectionTitleBar title={"Featured"} description={"설명"}/>
      <HorizontalComicList comicList={comics}/>
      <SectionTitleBar title={"오늘 연재"} description={"설명"}/>
      <VerticalComicList comicList={comics}/>
    </div>
  </>
}