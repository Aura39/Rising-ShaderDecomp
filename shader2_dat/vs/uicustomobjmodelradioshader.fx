float2 g_HalfPixel;
float2 g_RedOffset;
float2 g_UVOffset;
float4x4 g_ViewProjMatrix;
float4x4 g_WorldMatrix;
float g_ZSortOffset;

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
};

struct VS_OUT
{
	float4 position : POSITION;
	float2 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float3 r1;
	r0.x = dot(i.position, transpose(g_WorldMatrix)[0]);
	r0.y = dot(i.position, transpose(g_WorldMatrix)[1]);
	r0.z = dot(i.position, transpose(g_WorldMatrix)[2]);
	r0.w = dot(i.position, transpose(g_WorldMatrix)[3]);
	r1.x = dot(r0, transpose(g_ViewProjMatrix)[0]);
	r1.y = dot(r0, transpose(g_ViewProjMatrix)[1]);
	o.position.xy = r1.xy + g_HalfPixel.xy;
	r1.z = dot(r0, transpose(g_ViewProjMatrix)[2]);
	r0.x = dot(r0, transpose(g_ViewProjMatrix)[3]);
	o.position.z = r1.z * g_ZSortOffset.x;
	o.texcoord2.xyz = r1.xyz;
	o.texcoord = g_UVOffset.xy + i.texcoord.xy;
	o.texcoord1 = g_RedOffset.xy + i.texcoord.xy;
	o.position.w = r0.x;
	o.texcoord2.w = r0.x;

	return o;
}
