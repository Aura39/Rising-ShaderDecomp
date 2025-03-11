sampler A_Occ_sampler : register(s2);
sampler Color_1_sampler : register(s0);
sampler Shadow_Tex_sampler : register(s11);
float3 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c57);
float3 fog : register(c53);
float4 fogParam : register(c54);
float4 g_All_Offset : register(c60);
float g_ShadowUse : register(c180);
float4 g_TargetUvParam : register(c194);
float4 light_Color : register(c47);
float4 lightpos : register(c48);
float4 prefogcolor_enhance : register(c61);

struct PS_IN
{
	float4 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float3 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float4 texcoord7 : TEXCOORD7;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float3 r3;
	r0 = g_All_Offset.xyxy + i.texcoord.zwxy;
	r1 = tex2D(Color_1_sampler, r0.zwzw);
	r0 = tex2D(A_Occ_sampler, r0);
	r2 = r1.w + -0.5;
	clip(r2);
	r0.w = 1 / i.texcoord7.w;
	r2.xy = r0.ww * i.texcoord7.xy;
	r2.xy = r2.xy * float2(0.5, -0.5) + 0.5;
	r2.xy = r2.xy + g_TargetUvParam.xy;
	r2 = tex2D(Shadow_Tex_sampler, r2);
	r0.w = r2.z + g_ShadowUse.x;
	r2.xyz = normalize(i.texcoord3.xyz);
	r1.w = dot(lightpos.xyz, r2.xyz);
	r2.xyz = r1.www * light_Color.xyz;
	r1.w = r1.w + -0.5;
	r2.w = max(r1.w, 0);
	r3.xyz = r0.xyz + r2.www;
	r0.xyz = r0.xyz * r1.xyz;
	r1.xyz = r1.xyz * r3.xyz;
	r0.xyz = r0.xyz * ambient_rate.xyz;
	r2.xyz = r2.xyz * r0.www + i.texcoord2.xyz;
	r1.xyz = r1.xyz * r2.xyz;
	r0.xyz = r0.xyz * ambient_rate_rate.xyz + r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	r0.w = -fogParam.x + fogParam.y;
	r0.w = 1 / r0.w;
	r1.x = fogParam.y + i.texcoord1.z;
	r0.w = r0.w * r1.x;
	o.xyz = r0.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
