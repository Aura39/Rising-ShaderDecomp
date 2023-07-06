float4 g_Color;
float2 g_HalfPixel;
float2 g_RedOffset;
float4x4 g_ViewProjMatrix;
float4x4 g_WorldMatrix;
float g_ZSortOffset;
float2 g_addPos;
float3 g_param;

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 color : COLOR;
};

struct VS_OUT
{
	float4 position : POSITION;
	float2 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
	float3 texcoord2 : TEXCOORD2;
	float2 texcoord4 : TEXCOORD4;
	float4 color : COLOR;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float r1;
	r0.x = dot(i.position, transpose(g_WorldMatrix)[0]);
	r0.y = dot(i.position, transpose(g_WorldMatrix)[1]);
	r0.z = dot(i.position, transpose(g_WorldMatrix)[2]);
	r0.w = dot(i.position, transpose(g_WorldMatrix)[3]);
	o.position.w = dot(r0, transpose(g_ViewProjMatrix)[3]);
	r1.x = dot(r0, transpose(g_ViewProjMatrix)[2]);
	o.position.z = r1.x * g_ZSortOffset.x;
	r1.x = dot(r0, transpose(g_ViewProjMatrix)[0]);
	r0.x = dot(r0, transpose(g_ViewProjMatrix)[1]);
	r0.x = r0.x + g_HalfPixel.y;
	r0.y = r0.x + g_addPos.y;
	r0.z = r1.x + g_HalfPixel.x;
	r0.x = r0.z + g_addPos.x;
	o.texcoord1 = r0.xy * float2(0.5, -0.5) + 0.5;
	o.position.xy = r0.xy;
	o.color = g_Color * i.color;
	o.texcoord4 = g_RedOffset.xy + i.texcoord.xy;
	o.texcoord = i.texcoord.xy;
	o.texcoord2 = g_param.xyz;

	return o;
}
