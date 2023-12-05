export default function SectionTitleBar({title="", description=""}){
    return <div style={{background:"white", padding:"20px 30px 4px 30px"}}>
        <span style={{color:"black", fontSize: 22, display:"block", fontWeight: 600}}>{title}</span>
        <span style={{color:"black", fontSize: 16, display:"block", marginTop: 4, fontWeight: 400}}>{description}</span>
    </div>
}