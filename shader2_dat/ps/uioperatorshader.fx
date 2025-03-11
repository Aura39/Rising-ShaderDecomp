float4 g_Color : register(c62);
sampler g_Sampler0 : register(s11);
sampler g_Sampler1 : register(s12);
sampler g_Sampler2 : register(s13);
sampler g_Sampler3 : register(s14);
float4 g_ToneMapParam : register(c65);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
	float2 texcoord2 : TEXCOORD2;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float3 r3;
	float4 r4;
	r0 = tex2D(g_Sampler0, i.texcoord);
	r0.xyz = r0.xyz;
	r1.x = dot(r0.xyz, 0.299);
	r1.y = -r1.x + 1;
	r1.y = r1.y + r1.y;
	r2 = tex2D(g_Sampler1, i.texcoord1);
	r3.xyz = -r2.xyz + 1;
	r1.yzw = r1.yyy * -r3.xyz + 1;
	r3.x = r1.x + -0.5;
	r2.x = dot(r1.x, r2.x) + 0;
	r1.y = (r3.x >= 0) ? r1.y : r2.x;
	r3.y = lerp(r1.y, r1.x, r2.w);
	r4 = tex2D(g_Sampler2, i.texcoord2);
	r0.x = lerp(r4.x, r3.y, r4.w);
	r1.y = dot(r1.x, r2.y) + 0;
	r1.y = (r3.x >= 0) ? r1.z : r1.y;
	r3.y = lerp(r1.y, r1.x, r2.w);
	r0.y = lerp(r4.y, r3.y, r4.w);
	r1.y = dot(r1.x, r2.z) + 0;
	r1.y = (r3.x >= 0) ? r1.w : r1.y;
	r3.x = lerp(r1.y, r1.x, r2.w);
	r0.z = lerp(r4.z, r3.x, r4.w);
	r0 = r0 * g_Color;
	r1.x = dot(r0.xyz, 0.299);
	r1.x = g_ToneMapParam.z * r1.x + g_ToneMapParam.x;
	r1.y = g_ToneMapParam.y;
	r1 = tex2D(g_Sampler3, r1);
	r1.x = dot(r0.xyz, 0.5);
	o.x = r1.x * 1.402 + r1.w;
	r0.x = dot(r0.xyz, -0.16874);
	o.w = r0.w;
	r0.xy = r0.xx * float2(-0.34414, 1.722) + r1.ww;
	o.y = r1.x * -0.71414 + r0.x;
	o.z = r0.y;

	return o;
}
