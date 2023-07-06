float4 g_Color;
float2 g_TexelOffsets0;
float2 g_TexelOffsets1;
float2 g_TexelOffsets2;
float2 g_TexelOffsets3;
float2 g_TexelOffsets4;
float2 g_TexelOffsets5;
float2 g_TexelOffsets6;
float2 g_TexelOffsets7;
float4x4 g_ViewProjMatrix;
float4x4 g_WorldMatrix;

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 color : COLOR;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 color : COLOR;
	float2 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
	float2 texcoord2 : TEXCOORD2;
	float2 texcoord3 : TEXCOORD3;
	float2 texcoord4 : TEXCOORD4;
	float2 texcoord5 : TEXCOORD5;
	float2 texcoord6 : TEXCOORD6;
	float2 texcoord7 : TEXCOORD7;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	r0.x = dot(i.position, transpose(g_WorldMatrix)[0]);
	r0.y = dot(i.position, transpose(g_WorldMatrix)[1]);
	r0.z = dot(i.position, transpose(g_WorldMatrix)[2]);
	r0.w = dot(i.position, transpose(g_WorldMatrix)[3]);
	o.position.x = dot(r0, transpose(g_ViewProjMatrix)[0]);
	o.position.y = dot(r0, transpose(g_ViewProjMatrix)[1]);
	o.position.z = dot(r0, transpose(g_ViewProjMatrix)[2]);
	o.texcoord = g_TexelOffsets0.xy + i.texcoord.xy;
	o.texcoord1 = g_TexelOffsets1.xy + i.texcoord.xy;
	o.texcoord2 = g_TexelOffsets2.xy + i.texcoord.xy;
	o.texcoord3 = g_TexelOffsets3.xy + i.texcoord.xy;
	o.texcoord4 = g_TexelOffsets4.xy + i.texcoord.xy;
	o.texcoord5 = g_TexelOffsets5.xy + i.texcoord.xy;
	o.texcoord6 = g_TexelOffsets6.xy + i.texcoord.xy;
	o.texcoord7 = g_TexelOffsets7.xy + i.texcoord.xy;
	o.color = g_Color * i.color;
	o.position.w = 1;

	return o;
}
