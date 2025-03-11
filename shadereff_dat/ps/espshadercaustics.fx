float4x4 g_InvViewProjMatrix : register(c28);
float4 g_MatrialColor : register(c184);
float4 g_Rate : register(c185);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);
float4 g_TargetUvParam : register(c194);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float r2;
	r0 = tex2D(g_Sampler0, i.texcoord);
	r1.x = i.texcoord1.y * 0.5 + 0.5;
	r1.z = -r1.x + g_TargetUvParam.y;
	r2.x = 0.5;
	r1.x = i.texcoord1.x * r2.x + g_TargetUvParam.x;
	r1.xy = r1.xz + float2(0.5, 1);
	r1 = tex2D(g_Sampler1, r1);
	r1.z = r1.x;
	r1.xyw = i.texcoord1.xyx * float3(1, 1, 0) + 0;
	r0.x = dot(r1, transpose(g_InvViewProjMatrix)[0]);
	r0.y = dot(r1, transpose(g_InvViewProjMatrix)[1]);
	r0.z = dot(r1, transpose(g_InvViewProjMatrix)[2]);
	r0 = r0 * g_MatrialColor;
	o.xyz = r0.xyz;
	o.w = r0.w * g_Rate.x;

	return o;
}
