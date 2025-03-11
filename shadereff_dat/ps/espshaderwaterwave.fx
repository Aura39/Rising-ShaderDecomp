float4 g_MatrialColor : register(c184);
float4 g_Rate : register(c186);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);
samplerCUBE g_Sampler2 : register(s2);
float4x4 g_WorldMatrix_pix : register(c16);

struct PS_IN
{
	float3 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = tex2D(g_Sampler1, i.texcoord);
	r0.xy = r0.xy + -0.5;
	r0.xy = r0.xy + r0.xy;
	r0.w = dot(r0.w, -r0.w) + 1;
	r0.w = 1 / sqrt(r0.w);
	r0.z = 1 / r0.w;
	r1.xyz = normalize(r0.xyz);
	r0.x = dot(r1.xyz, transpose(g_WorldMatrix_pix)[0].xyz);
	r0.y = dot(r1.xyz, transpose(g_WorldMatrix_pix)[1].xyz);
	r0.z = dot(r1.xyz, transpose(g_WorldMatrix_pix)[2].xyz);
	r1.xyz = normalize(r0.xyz);
	r0.xyz = normalize(i.texcoord1.xyz);
	r0.w = dot(r0.xyz, r1.xyz);
	r0.w = r0.w + r0.w;
	r0.xyz = r1.xyz * -r0.www + r0.xyz;
	r0 = tex2D(g_Sampler2, r0);
	r0.xyz = r0.xyz * g_Rate.yyy;
	r1.xy = g_Rate.xx * i.texcoord.xy;
	r1 = tex2D(g_Sampler0, r1);
	r0.w = i.texcoord.z * i.texcoord.z;
	r0.w = r0.w * i.texcoord.z;
	r1.xyz = r0.www * r1.xyz;
	o.xyz = r1.xyz * g_MatrialColor.xyz + r0.xyz;
	o.w = 1;

	return o;
}
