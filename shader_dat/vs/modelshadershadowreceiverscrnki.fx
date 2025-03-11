float4x4 g_ShadowView : register(c32);
float4x4 g_ShadowViewProj : register(c28);
float4x4 g_ShadowViewProj2 : register(c195);
float4x4 g_ShadowViewProj3 : register(c199);
float4x4 g_World : register(c16);
float4x4 g_WorldViewProj : register(c24);

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 normal : NORMAL;
};

struct VS_OUT
{
	float4 position : POSITION;
	float3 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float2 texcoord4 : TEXCOORD4;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float3 r2;
	float3 r3;
	float3 r4;
	r0 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	o.position.x = dot(r0, transpose(g_WorldViewProj)[0]);
	o.position.y = dot(r0, transpose(g_WorldViewProj)[1]);
	o.position.z = dot(r0, transpose(g_WorldViewProj)[2]);
	o.position.w = dot(r0, transpose(g_WorldViewProj)[3]);
	r1.x = dot(r0, transpose(g_World)[0]);
	r1.y = dot(r0, transpose(g_World)[1]);
	r1.z = dot(r0, transpose(g_World)[2]);
	r1.w = dot(r0, transpose(g_World)[3]);
	o.texcoord1.x = dot(r1, transpose(g_ShadowViewProj)[0]);
	o.texcoord1.y = dot(r1, transpose(g_ShadowViewProj)[1]);
	o.texcoord1.w = dot(r1, transpose(g_ShadowViewProj)[3]);
	o.texcoord2.x = dot(r1, transpose(g_ShadowViewProj2)[0]);
	o.texcoord2.y = dot(r1, transpose(g_ShadowViewProj2)[1]);
	o.texcoord2.z = dot(r1, transpose(g_ShadowViewProj2)[2]);
	o.texcoord2.w = dot(r1, transpose(g_ShadowViewProj2)[3]);
	o.texcoord3.x = dot(r1, transpose(g_ShadowViewProj3)[0]);
	o.texcoord3.y = dot(r1, transpose(g_ShadowViewProj3)[1]);
	o.texcoord3.z = dot(r1, transpose(g_ShadowViewProj3)[2]);
	o.texcoord3.w = dot(r1, transpose(g_ShadowViewProj3)[3]);
	r0.x = dot(r1, transpose(g_ShadowView)[2]);
	o.texcoord1.z = abs(r0.x) * 0.005;
	r0.xyz = transpose(g_World)[1].xyz;
	r1.xyz = r0.xyz * transpose(g_ShadowView)[0].yyy;
	r2.xyz = transpose(g_World)[0].xyz;
	r1.xyz = r2.xyz * transpose(g_ShadowView)[0].xxx + r1.xyz;
	r3.xyz = transpose(g_World)[2].xyz;
	r1.xyz = r3.xyz * transpose(g_ShadowView)[0].zzz + r1.xyz;
	r4.xyz = transpose(g_World)[3].xyz;
	r1.xyz = r4.xyz * transpose(g_ShadowView)[0].www + r1.xyz;
	o.texcoord.x = dot(i.normal.xyz, r1.xyz);
	r1.xyz = r0.xyz * transpose(g_ShadowView)[1].yyy;
	r1.xyz = r2.xyz * transpose(g_ShadowView)[1].xxx + r1.xyz;
	r1.xyz = r3.xyz * transpose(g_ShadowView)[1].zzz + r1.xyz;
	r1.xyz = r4.xyz * transpose(g_ShadowView)[1].www + r1.xyz;
	o.texcoord.y = dot(i.normal.xyz, r1.xyz);
	r0.xyz = r0.xyz * transpose(g_ShadowView)[2].yyy;
	r0.xyz = r2.xyz * transpose(g_ShadowView)[2].xxx + r0.xyz;
	r0.xyz = r3.xyz * transpose(g_ShadowView)[2].zzz + r0.xyz;
	r0.xyz = r4.xyz * transpose(g_ShadowView)[2].www + r0.xyz;
	o.texcoord.z = dot(i.normal.xyz, r0.xyz);
	o.texcoord4 = i.texcoord.xy;

	return o;
}
