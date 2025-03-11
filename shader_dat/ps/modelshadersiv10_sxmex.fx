sampler A_Occ_sampler : register(s2);
sampler Color_1_sampler : register(s0);
sampler Shadow_Tex_sampler : register(s11);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
float3 fog : register(c67);
float4 g_All_Offset : register(c76);
float g_ShadowUse : register(c180);
float4 g_TargetUvParam : register(c194);
float4 light_Color : register(c61);
float4 lightpos : register(c62);
float4 prefogcolor_enhance : register(c77);
float4 specularParam : register(c41);
sampler specularmap_sampler : register(s5);

struct PS_IN
{
	float4 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float4 texcoord7 : TEXCOORD7;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float2 r4;
	r0.x = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r0.x = 1 / sqrt(r0.x);
	r0.xyz = -i.texcoord1.xyz * r0.xxx + lightpos.xyz;
	r1.xyz = normalize(r0.xyz);
	r0.x = dot(r1.xyz, i.texcoord3.xyz);
	r1.x = pow(r0.x, specularParam.z);
	r0.y = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.z = (-r0.y >= 0) ? 0 : 1;
	r0.y = r0.y * r0.z;
	r0.x = (-r0.x >= 0) ? 0 : r0.z;
	r0.x = r1.x * r0.x;
	r0.yzw = r0.yyy * light_Color.xyz;
	r0.xyz = r0.xxx * r0.yzw;
	r1 = g_All_Offset.xyxy + i.texcoord.zwxy;
	r2 = tex2D(specularmap_sampler, r1.zwzw);
	r0.xyz = r0.xyz * r2.xyz;
	r0.w = 1 / i.texcoord7.w;
	r2.xy = r0.ww * i.texcoord7.xy;
	r2.xy = r2.xy * float2(0.5, -0.5) + 0.5;
	r2.xy = r2.xy + g_TargetUvParam.xy;
	r2 = tex2D(Shadow_Tex_sampler, r2);
	r0.w = r2.z + g_ShadowUse.x;
	r0.xyz = r0.www * r0.xyz;
	r2.xyz = ambient_rate.xyz;
	r2.xyz = r0.www * ambient_rate_rate.xyz + r2.xyz;
	r3 = tex2D(A_Occ_sampler, r1);
	r1 = tex2D(Color_1_sampler, r1.zwzw);
	r4.xy = -r3.yy + r3.xz;
	r0.w = max(abs(r4.x), abs(r4.y));
	r0.w = r0.w + -0.015625;
	r1.w = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.w;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r3.xz = (r0.ww >= 0) ? r3.yy : r3.xz;
	r0.xyz = r0.xyz * r3.xyz;
	r2.xyz = r3.xyz * r2.xyz + i.texcoord2.xyz;
	r0.w = abs(specularParam.x);
	r0.xyz = r0.www * r0.xyz;
	r3.xy = -r1.yy + r1.xz;
	r0.w = max(abs(r3.x), abs(r3.y));
	r0.w = r0.w + -0.015625;
	r1.w = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.w;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r1.xz = (r0.ww >= 0) ? r1.yy : r1.xz;
	r0.w = 1 / ambient_rate.w;
	r3.xyz = r1.xyz * r0.www + specularParam.www;
	r1.xyz = r0.www * r1.xyz;
	r0.xyz = r0.xyz * r3.xyz;
	r0.xyz = r1.xyz * r2.xyz + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord2.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
