'use client'
import ToolBar from "./components/ToolBar";
import React from "react";
import {useSearchParams} from "next/navigation";
import EpisodeItem from "./components/EpisodeItem";

export default function Comic() {
    const TOOLBAR_HEIGHT = 70
    const params = useSearchParams()

    //todo: DB 연결
    const title = "웹툰 ID : " + params.get("id")
    const episodes = [
        {id: 1, thumb: "https://source.unsplash.com/500x500", title: "Test", episode_num: 1},
        {id: 2, thumb: "https://source.unsplash.com/500x500", title: "Test", episode_num: 2},
        {id: 3, thumb: "https://source.unsplash.com/500x500", title: "Test", episode_num: 3},
        {id: 4, thumb: "https://source.unsplash.com/500x500", title: "Test", episode_num: 4},
    ]

    return (
        <>
            <ToolBar title={title} height={TOOLBAR_HEIGHT}/>

            <div style={{paddingTop: TOOLBAR_HEIGHT, background: "white"}}>
                {episodes.map(item => <EpisodeItem
                    key={item.id}
                    path={"/episode?id=" + item.id}
                    height={70}
                    title={item.title}
                    thumb={item.thumb}
                />)}
            </div>
        </>)
}