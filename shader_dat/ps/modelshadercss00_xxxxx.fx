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
sampler normalmap_sampler : register(s1);
float4 prefogcolor_enhance : register(c77);
float4 sectionParam : register(c41);
float4 specularParam : register(c42);
float4 tile : register(c44);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
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
	float3 r3;
	r0.xyz = i.texcoord3.xyz;
	r1.xyz = r0.yzx * i.texcoord2.zxy;
	r0.xyz = i.texcoord2.yzx * r0.zxy + -r1.xyz;
	r1.xy = g_All_Offset.xy;
	r1.xy = i.texcoord.xy * tile.xy + r1.xy;
	r1 = tex2D(normalmap_sampler, r1);
	r1.xyz = r1.xyz + -0.5;
	r0.xyz = r0.xyz * -r1.yyy;
	r0.w = r1.x * i.texcoord2.w;
	r0.xyz = r0.www * i.texcoord2.xyz + r0.xyz;
	r0.xyz = r1.zzz * i.texcoord3.xyz + r0.xyz;
	r1.xyz = normalize(r0.xyz);
	r0.x = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r0.x = 1 / sqrt(r0.x);
	r0.xyz = -i.texcoord1.xyz * r0.xxx + lightpos.xyz;
	r2.xyz = normalize(r0.xyz);
	r0.x = dot(r2.xyz, r1.xyz);
	r0.y = dot(lightpos.xyz, r1.xyz);
	r1.x = pow(r0.x, specularParam.z);
	r0.z = r0.y;
	r0.w = (-r0.z >= 0) ? 0 : 1;
	r0.z = r0.z * r0.w;
	r0.x = (-r0.x >= 0) ? 0 : r0.w;
	r0.x = r1.x * r0.x;
	r1.xyz = r0.zzz * light_Color.xyz;
	r0.xzw = r0.xxx * r1.xyz;
	r1.x = 1 / i.texcoord7.w;
	r1.xy = r1.xx * i.texcoord7.xy;
	r1.xy = r1.xy * float2(0.5, -0.5) + 0.5;
	r1.xy = r1.xy + g_TargetUvParam.xy;
	r1 = tex2D(Shadow_Tex_sampler, r1);
	r1.x = r1.z + g_ShadowUse.x;
	r0.xzw = r0.xzw * r1.xxx;
	r1.x = abs(specularParam.x);
	r0.xzw = r0.xzw * r1.xxx;
	r1.xy = g_All_Offset.xy + i.texcoord.xy;
	r1 = tex2D(Color_1_sampler, r1);
	r2.xy = -r1.yy + r1.xz;
	r3.x = max(abs(r2.x), abs(r2.y));
	r2.x = r3.x + -0.015625;
	r2.y = (-r2.x >= 0) ? 0 : 1;
	r2.x = (r2.x >= 0) ? -0 : -1;
	r2.x = r2.x + r2.y;
	r2.x = (r2.x >= 0) ? -r2.x : -0;
	r1.xz = (r2.xx >= 0) ? r1.yy : r1.xz;
	r2.w = sectionParam.w;
	r2.x = r2.w * 0.1;
	r2.x = abs(r2.x) * sectionParam.w;
	r1.w = r1.w * r2.x;
	r1.xyz = r1.www * 0.01 + r1.xyz;
	r1.w = r1.w * 0.01;
	r2.xyz = r1.www * sectionParam.xyz;
	r3.xyz = r1.xyz + specularParam.www;
	r1.xyz = r1.xyz * ambient_rate.xyz;
	r1.xyz = r1.xyz * ambient_rate_rate.xyz + r2.xyz;
	r0.xzw = r0.xzw * r3.xyz;
	r1.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.y = r0.y + -r1.w;
	r0.y = r0.y + 1;
	r0.xyz = r1.xyz * r0.yyy + r0.xzw;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
